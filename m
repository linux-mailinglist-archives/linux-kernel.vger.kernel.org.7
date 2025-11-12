Return-Path: <linux-kernel+bounces-896344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9F5C5026E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE731899397
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F121FF5B;
	Wed, 12 Nov 2025 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RhZEpTFF"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8D21255A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908672; cv=none; b=BoPaGhHsH+T6RX9B0gVN/ByhC+rkoxAVSN8piwVq9U8HZ2lDvFO4XMsNqAvkhmXEWefV1rDE2635yRu0r4oJALp8pd28VNaazkQi3LCxmNzBDZLtzFjTfz1gsXbjeitTcYGDjz/6TPVbtQajAXuPUmSZte6MdWS3BL1CMAb9KXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908672; c=relaxed/simple;
	bh=2OdtSOueaZaNgax+sB7JoUsjE/Nm6EW3iaLsDMs/rBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkoNyucHFLL/ukTNAAnKOuXbtOj0M1KdjXs+S7h08sKAyzKr+qNsD2mtqWt3p5BOi07V0rI6bQtw3Xr5xco9IK0EA7FSbmc2BvphgjBIw7xEcxZl870ocHEugldMJ0faRcXlH77CXShrVkL1HX8HD/Y7hGI3Fbm9uQBns+gqTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RhZEpTFF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7ade456b6abso229068b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762908668; x=1763513468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OdtSOueaZaNgax+sB7JoUsjE/Nm6EW3iaLsDMs/rBw=;
        b=RhZEpTFFtdtR3Viwa/iojH8QZc0uv6rCAJCHnQXm3p4iQKnnRzJvZCRyMCGF+EZDKU
         c7RiUo/dpGG2jTaZR+4lOfTYvlNDbiy5KjkXmm6n5qKhMCOr1DYXyaQoXO5voeLoohU9
         lfbcxEVS/W/EWlJ26o7kVXzcdzlG6Fo9ypKoGkZk6yIBo3EJIrMCmPJMT+Dr4G7Nt3xz
         bVNyQQv81q3SFjcag/unIsycm4FGKEkA8CsxzEkgi9tQ6lIKydYRXA0SXnjp1crxjuXG
         /fZ06eOisNsGWVW0Btbwq/y5+aUN9PMhJuUSyMBpqKWuDYFFBn5X7kWlT2UncLHezyaS
         tG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762908668; x=1763513468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OdtSOueaZaNgax+sB7JoUsjE/Nm6EW3iaLsDMs/rBw=;
        b=r9OMOUV7Iod3Is4QiQBGtlQFdeX9ZqLfhgFS+njj2dbzZhYMMNTOO0St3h18dzOXz/
         0GdcoiAkCPkUEjYvlsr8Porpk6iXE36lEJAgJ9kS41rE6PF8vNpggBenIai0IVMkMDRL
         pNv9Ma+D+cq+4VzoNKXNMxFT4ujvb1eRwVA3//tOyhiLKRVdbQfnJzO2Yw3f75tDCYCR
         rAtu9658U+McUxp6xUBs5sVg5Ekx4xU24+rHYuY239Z6ZzfT7jj23amC19NBNsWAwAee
         aUcDX55HGKwpOnGgg8aEzdEXCLY4oW2dbYGwoXGJxJTJVzn0gJ73Pms2JqiCycXPN63n
         fr5w==
X-Gm-Message-State: AOJu0YzK+XdIAL/0+JCL8W+tbqQdRd1sVEzMNiqVUIgWGfFTjm/yiJxv
	wP9Xcta/gyQL4sIcmYErN0HgxpnN0Kn1to4XITAJFzPzHO2v8kUCBY7RHrR6nwE3qig2eTEZRyN
	XnOf95BKXRnnqy4y02HIjq1pXjTfZiWLvZr7QmfjVh5flQgIdATY=
X-Gm-Gg: ASbGncsks/Qj8xY3RgqBbkZNCvHoxvgtk3nAdyc+vQWdOoG4s/jULURiFdZPcfI8X9p
	s45OiMsL9KGhO1FyODVFl3mMyTj6uynoF08rJqWQ+Z1kJ7vay1z4fDKnNdB6ZSuSOIE97lR5JIH
	q4wbjReRBxZUiPbrAV0DNnjBvim4ftUViMnbxK8iuFDH4GH1mrg/WKFPHNMwx5teyQstGzIAkX4
	YbKqR8xrTYVvPFABJwBtO+oepBKBbVpjxuy0CzyGUSjo3dK274OKDCyIRBd
X-Google-Smtp-Source: AGHT+IHkU9Wi+f6GWyr7DCrdh0j5tDoAb9Pyt1Zcj+wtUB8thJZutmMijomHYviD35MHQ2X7Do+YYwDJ78RL0a8/fpE=
X-Received: by 2002:a05:6a20:3c8e:b0:351:db7:2328 with SMTP id
 adf61e73a8af0-3590988ba6fmr1386791637.16.1762908668426; Tue, 11 Nov 2025
 16:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103113922.61232-2-bagasdotme@gmail.com> <aRKgyvrTxldlTv9t@archie.me>
In-Reply-To: <aRKgyvrTxldlTv9t@archie.me>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 11 Nov 2025 19:50:56 -0500
X-Gm-Features: AWmQ_bnXawPFNQPn16cCqSB2CtDY0qEbTQIVjy089Pp9K6h9E_gK01U2_7eHOts
Message-ID: <CAHC9VhQeghqosexgOQO3==poNwsf_6mNiOqkUTUOdYnzRYzKmQ@mail.gmail.com>
Subject: Re: [PATCH] security: sctp: Format type and permission checks tables
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, 
	Linux Security Module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Kees Cook <kees@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Stuart Yoder <stuart.yoder@arm.com>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 9:35=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Mon, Nov 03, 2025 at 06:39:23PM +0700, Bagas Sanjaya wrote:
> > Use reST grid tables for both type and permission checks tables.
>
> review ping

You don't need to 'ping' for a review, your patch is in my review
queue, but code changes take priority at this point in the dev cycle
as I'm okay with merging documentation changes fairly late.

--=20
paul-moore.com

