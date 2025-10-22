Return-Path: <linux-kernel+bounces-864270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F709BFA58D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BACB4F76E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB92F2619;
	Wed, 22 Oct 2025 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0Op8MER"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956D2D7DE7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115951; cv=none; b=FnQ6dQ/RpHA4UfYw+tljguAcerPuqwpYIR0sNiafiOeBniRohfKd1LOobYo8zEap5xwLy3ReVsfYIu8tfxZABFpMa4O+MovfVaczMaaqii3roE3gHDFHRkgYb2xIWEVi8iMN9IJQnBqp/K5n/VVQ6UCnao70MH888eOL7lxZYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115951; c=relaxed/simple;
	bh=s52Slkr6wkat7EzJCzoI0soaZIqwObWpYaED/LO6pXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8invh+cFIRlZJkWQV7HJsBDRZd02CR/p412k5SnPvW/xps6Cq9qEijkZpwejoKh9DG70IpSyBOvZNGT5b/9nHerABn0j2MOyiS+PEhBiYIp/7qc+8HvvbMeVOKO7lY/v+G1P7uCFyZ1yikTmH7znV1tBpNk/WQzfEonMh1XYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0Op8MER; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so5363617a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761115949; x=1761720749; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cfCAtQxbjLOYFKdU41YYM4nSvS1I4T1EjpHpy1QIl2Y=;
        b=M0Op8MERGvvNYr3uZy5Lo4KydLmboaNi+dNz6f5d97ZEMjAF4xqyfmHenEQKTa10fh
         6nPCCHvQfTZrqQOgqj/vSJE5nKYHXxZ1w+sfKd8sGsnZHRFuJ0JhPUGJWiJ39DJGiXIL
         2brV4vM2RCBIzBfC3628dQl5Xe63ws7kiDuxn0SKeod/YdDIkYrKFVJ9AbX8Run/PgaY
         JQ8HQb6d+6d3RNPJa/mGjN0h35VZtgEBLnp4tCsg0tqYYL3C4J1mpMeSYQeHEOymButa
         d8W8GSlkDfBXvvXFwehjYp4sl/le4219sZ/OOMWsrCl1TisNdyjrh3vgHzFFrbh7gb4I
         pxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115949; x=1761720749;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfCAtQxbjLOYFKdU41YYM4nSvS1I4T1EjpHpy1QIl2Y=;
        b=ou0etm9f1P8CeAtSryMdTHwUxPBpMt7181FVvZf5sjhldTu68/IeCNXRSCwk1YZxKM
         60BOB/WozxIuS2WZnxujTJikO51h8IOp/d+cjgVIM1qrX56W29b+ztKK00PWebv9RrRF
         Zz/2LFRlTN2bZQcx1hgwB0EdFphZzKsfXfH+fBtnBnizxlAB7A5gitTmapTtRdRwdXO9
         4HFhqofoScjp+wF+ij4cqgy7Yd2RC/1QWimvTk/Pm2TIUyKsUmFB0UilmP4DUdg8Nujx
         NeAQpUdhNhY2FusAkIpDq1kk3NLeXp3TzdgLKv8PKDa/TzRNzl+Y3m0sku3CK6y1RPKj
         JIng==
X-Forwarded-Encrypted: i=1; AJvYcCXoihLfly2TtMGhUlJf5wdJSshr+ZQQrv/sfIBA8kK2KE/TquGjtZEhpxbHNCwTFuoR0S3IOsW7Dcg1MZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3uQfc6srtMUyzFv/sv6fMk0wfAWB4njeigXYr3Y8KXDCrLEi
	+zxZI37DKViRIYeUF2sTjWDhyANjMRvPjkocqa8mOXPCm/kJpbMuzUWF
X-Gm-Gg: ASbGnctfRoH03cPk5aMPw3tEkY957bjKPcP64g9nJ6FBoe+U0G+fAeV5WlCCklCTESA
	+sTJUNhPtjA81Nd8FRB9ZtP11BW1JRcrfQQ+eE7ZZ6hHdTy8T26NR1S6u/Ov5Vjce0HsxTHovLV
	3arHZ9MVOI85z5Kw3sdXJcr337DEXc0M5yMIdzCo2wahJqH2ZBlJk1wPtB5yg/RHNnXkFHnc7Rl
	jOSalSsIFX1ceFchOlS0q8HJaP0w5rWDb0fBgDDZo60/hH+RHGjtx+GzsSVqgKbuHbPpbZ+u69l
	vNkceKt0RLHpe5nfmbLMIPncOBNkwXMhOCclVjUOaDEdltHgrDKoc4zfe8rb+1OMgpjdYrPFpeW
	+P5IlZql6twaLuvgHYBFrSv9mUws9TWPXhSQzGXI1NYMTazW3oo+fqVrWtz97g8ZfReRqoB0oiC
	7hzdch2FEnhMtvt8Ch5fSl8utyohWvx+HOypHOHPf+1/bZGD8=
X-Google-Smtp-Source: AGHT+IFMSuTEE8EAynNZfouzzGpRK3ZPx5DA2CURr/ENLw6IvstVTll4IoLJt+N4CU1a3g16jTSfkA==
X-Received: by 2002:a17:903:2441:b0:271:479d:3de3 with SMTP id d9443c01a7336-290c9c93d94mr258464315ad.12.1761115949501;
        Tue, 21 Oct 2025 23:52:29 -0700 (PDT)
Received: from ?IPv6:2401:4900:6575:cc6c:809f:5c1e:f090:c761? ([2401:4900:6575:cc6c:809f:5c1e:f090:c761])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm129655605ad.54.2025.10.21.23.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:52:29 -0700 (PDT)
Message-ID: <9e80ec7909b40e662ea719d97151b9e6dbf8faab.camel@gmail.com>
Subject: Re: [PATCH v2] Documentation: fix dev-tools broken links in
 translations
From: ally heev <allyheev@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, Yanteng
 Si	 <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, Hu Haowen	
 <2023002089@link.tyut.edu.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Date: Wed, 22 Oct 2025 12:22:23 +0530
In-Reply-To: <87qzuwt3hk.fsf@trenco.lwn.net>
References: 
	<20251020-aheev-fix-docs-dev-tools-broken-links-v2-1-7db64bf0405a@gmail.com>
	 <87qzuwt3hk.fsf@trenco.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 14:16 -0600, Jonathan Corbet wrote:
> Ally Heev <allyheev@gmail.com> writes:
>=20
> > gdb and kgdb debugging documentation were moved to
> > Documentation/process/debugging/ as a part of
> > Commit d5af79c05e9382d38b8546dc5362381ce07ba3d1 ("Documentation: move
> > dev-tools debugging files to process/debugging/"), but translations/
> > were not updated. Fix them
> >=20
> > ---
> > Link: https://lore.kernel.org/all/20241210000041.305477-1-rdunlap@infra=
dead.org/
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > ---
> > Changes in v2:
> > - fix kgdb doc path in zh_TW/admin-guide/README.rst
> > - Please drop v1 of the patch. It is malformed. Link to v1: https://lor=
e.kernel.org/r/20251020-aheev-fix-docs-dev-tools-broken-links-v1-1-5d127efe=
c0b2@gmail.com
> Putting your signoff after the "---" line caused the tooling to not
> include it in the resulting commit.  I've fixed that up this time, and
> added a Fixes: tag as well.
> Applied, thanks,
>=20
> jon

Sorry for that. b4 messed up the formatting

Regards,
Ally

