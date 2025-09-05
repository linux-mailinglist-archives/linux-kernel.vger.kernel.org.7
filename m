Return-Path: <linux-kernel+bounces-803794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D656B46561
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DF93BC763
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2A2DAFB1;
	Fri,  5 Sep 2025 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UE8du2e"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CDA1F30AD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107098; cv=none; b=O/BCO/pH2KkuH+hkIH03F4LZRWyE5UD9DPxQHlt1PkBcrTyb89QUS6GDYe5yPnGYYH89wdjOUZqeXS0kTkUustsP1eZdoyPSBG/o3UA2n7s3du0L+JFbh/Eod5L1rz6xvweYOgyyfYYnI/wfyR4waBRZ5tALr85kU93hp/oZLw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107098; c=relaxed/simple;
	bh=V/qpY5woUvgQHrdaj3qqGLb87THxgyLrGvJPAhxQ/nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jr5bohOMGT9nMB9N0Tb/iGntVDExUIs/HoJCGDVsDjEacwdhe8dWP87WfJKoGB692OMV6+7eVmnZBZAvf3TgCtduTALkQTftW1L8M1ctQmzqDWYjRR+BhWX7oBfiXvVET6nMKofg9/UqRKTbzrISxhHzEpRFKRhv/xOjEflQNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UE8du2e; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24b2d018f92so25615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757107097; x=1757711897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/qpY5woUvgQHrdaj3qqGLb87THxgyLrGvJPAhxQ/nk=;
        b=0UE8du2eQMB2JLuaZUUDbOCEppHLocy6wviB5wi/dgzau0tXcCb+8x4xpqj0QH7tfH
         Il+Df1w8QYjI43ishUMKLNdiVr34qnnTciCJn8Kl10npxFlgc/It7Sy8sOmVqRlAd7Og
         lvqWRBltGtwoQX6lJoGB74vGr4iLOQPaY1EX2MCoXva7W/9I6Drrm4canztfb2mRmhf6
         1B/J9uoskScNZ2ThWwlTHTA3VmhSa/beiZ1FHsEPd5+Q6Wg6YLFdh0XoLA/iHfoHA6uF
         zHeSnPubuc/YZyCQUF+jrXfoMFlj48qDDZXhcukZVCktA8xw+jIyryREFW7iWJCGNjuf
         4/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107097; x=1757711897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/qpY5woUvgQHrdaj3qqGLb87THxgyLrGvJPAhxQ/nk=;
        b=NKJtXYOYqwWjgR8SjsupVICut1h80w4I9Lk7zF3l/DTfnvFE49zHsMF1OZ2oD4qjvt
         ibnWkbxfyFoaFektcmdOcWGfTy1YBhSDQKhgizDHwPHA1xy5ejDW3bbCGmRRZpxKWzWW
         Oku/+WuPZe0nN30vHZI4bPqcrDASaqSMJCzhbNZU/OhflRXx3olPSmwshy9GVgPM0V3D
         1AGaC+Cs8vdVbplz9iBWKpRLHcU6OueGGM3iu1kOmbRpYQbhi01h6cWRN7i5lVqQiAST
         tHTXzpwnfvHejX5Hv8sg1N+PEOCt7TKPj8QrSNBAjo9wWSwf2UMVIhq62hg2k9+zocEr
         wkZA==
X-Forwarded-Encrypted: i=1; AJvYcCUHdrnUjqTkX3CWtanyjIfJreXZ2KCRtJVFncVYgDyvDB9n0VpFeHyI0dL/rt3+2fxN2GRITbJa4bhTNNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhPc+3y9DN9NoohVCEUdyw8OOPyKKDj4e2F537QvdSx8jf3ma
	xsxxSvTkqsCpdlcAS1uG81/Hz077d9llguFBXJ2unfAHTWtkoFzXVEWf5mPXEX3Xk6xk/epwfOY
	m8XrVljfAqw8abza8ayBsOEd+NkOfGXAfmo7zs7r9
X-Gm-Gg: ASbGncvHqYtsjxZwRraliwNGdi93Kzy/BqvXf446zPg4XEj7/IAlGW9ijQCAGUNlT/i
	OoV4O6+GJZPU9b+1T3YUVJaBE8e8VS7Fd8Gbe/1rB7tpQcyGKoBIMmMPcoH9oWUf/OOwnGjVkcQ
	vO8k4OuaHD69GVFQCstUm/mQzEDhaWqPDK2h2RtMwVrsBlfk91ugqbPzhHU+z+zzFUY9QKxIWpL
	hwRHH6+utrn5JkXSRO8TRzxQ9GFP1WTNytaTgC2r2gqUeIkltvJMpJ9CQ==
X-Google-Smtp-Source: AGHT+IFcLpRsdpcaR2Zbamq8gP687RXFQRE4U1ntmAJRlT1y+cLD7TO7+OK6VdTfQ8je95KqqncHaDR1YcpaNnM6xxo=
X-Received: by 2002:a17:903:186:b0:24c:863a:4ccc with SMTP id
 d9443c01a7336-25114efbaaamr929595ad.4.1757107096329; Fri, 05 Sep 2025
 14:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818071304.1717183-1-elena.reshetova@intel.com> <287a2652-bce6-4084-b9b5-c8feb24a2940@intel.com>
In-Reply-To: <287a2652-bce6-4084-b9b5-c8feb24a2940@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 5 Sep 2025 14:18:02 -0700
X-Gm-Features: Ac12FXwylkx_TogxWguH-xMuqhZXQbHUyMu-O4qezVTEb5xVX9w6CcUkZbgeMHE
Message-ID: <CAGtprH8rPg30gsrhJ9=44uaePqf-Ay=R+O_+D8isH8TzM4uQXQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/5] Enable automatic SVN updates for SGX enclaves
To: Dave Hansen <dave.hansen@intel.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>, jarkko@kernel.org, seanjc@google.com, 
	kai.huang@intel.com, mingo@kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, asit.k.mallick@intel.com, 
	vincent.r.scarlata@intel.com, chongc@google.com, erdemaktas@google.com, 
	bondarn@google.com, scott.raynor@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:37=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 8/18/25 00:11, Elena Reshetova wrote:
> > Testing
> > -------
> >
> > Tested on EMR machine using kernel 6.17.0_rc1 & sgx selftests.
> > Also tested on a Kaby Lake machine without EUPDATESVN support.
> > If Google folks in CC can test on their side, it would be greatly
> > appreciated.
>
> Yeah, lots of @google.com addresses on Cc, but there's a dearth of tags
> from those addresses.

Apologies for the delay on this one, Elena. We will get back on this
early next week.

