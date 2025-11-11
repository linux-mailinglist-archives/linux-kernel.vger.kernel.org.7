Return-Path: <linux-kernel+bounces-894362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22EC49D88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CDB3AEFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746E7CA5E;
	Tue, 11 Nov 2025 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B6DDQaN0"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FD34D39B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819947; cv=none; b=PIa9ldO8OT89/1pIi2gp3jptXOrA1SM9TQqhkuSftyFnnVnEC53vE5t10QXTap/AHNy3oYcJ+mpLZqDf90DgTiABTbyRFohez0tQXYe3P/MORuenp9rRkDUE+S5s9laREArS62DuIyP9P8Kn8aCmAHMFOy3xAhy7o88SPLaxL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819947; c=relaxed/simple;
	bh=40COxiieaHqw7+ui24NSWgLnvMT1wpUASlkNw1A/gos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3WKPufhu40RwW2KAjgVE05U/5WODSIVJbw6YpkmfoncDrNX6S+biP/OUwW9bPOjv/2gFWneKsRuzWgmPxB8kr3OAANDflE5TiyUoUzXh58s0G4puaFGbqdjsag98OjWa/U03KScrgt622y2btl7/vC4ne9olRWmKsDtjQ11mxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B6DDQaN0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso2759525a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762819946; x=1763424746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuW6q1y8DG7tuVTrZRJrDQaASYmc2YGPYqwUbsMWjj0=;
        b=B6DDQaN0HLMlNds9B8k5HAbOixH1tfBoHsho0CUKe6JSQTw1ZCp0Dg+c7DtSBecQI/
         A29R93oya5G28sUCAJCv0xYBjc7JGltpj+T8PkTNcPPXc5LF/6rqvo5BQFe2aIRBGNez
         c69HaD3sP+za5FpD7jDiz7/DHt1uFkWv/V6v39giK+dCDLGwdsU1aFGeFBznHCxPNKr7
         5sdeMx398HQ8hnyX+TLYR3MnsPUKBqfps2ftzIcGnS3JPVe7PZaB6eEJ+rSnTsmfSagd
         XbptjrhKAONy1GdnOGO3fbqZjd62vPkjXWvslsJ7HqjZHyoRsxYi2pSzH3dNy/dty7pu
         zsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819946; x=1763424746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuW6q1y8DG7tuVTrZRJrDQaASYmc2YGPYqwUbsMWjj0=;
        b=dqgwtVEUbRW33L4+JXzPWABWtm4I36v8aUQS4xg7oqlvGQOC8ogr670+SoGy0gIRR2
         gAIRcaB1f3rsHOSul5Nbqb2utMwK8MVthlqxLLYoecrORGk846np6877bCI5kiHE5w+3
         Tx/oiD6xlEkTOQdTX5JKYUIt2nOxvgL2ecfAA1hCjKMd4pI6zBXwPa94mpzRr7gAbbSF
         UK0BPw2L6Lyu3FLkLuNGDY1AjLstloNsCqX5HqeweA0RWBo5cAJm7xc7zpV4vlSDRR8D
         VMt3mpdpGRW5N6TBMm6WiVlrcnP/5LpEUADOWiSDnoiXPTd9vxTovNqvovtw16qsDQao
         HhXg==
X-Forwarded-Encrypted: i=1; AJvYcCX/d8GA8uAx8TAbBKbNmG95WsT2O/gKYLUcgJS9MwnojtB7b7s3+bkF2DYMAOjmnnTSIkBIMQq20KrxQOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbiU2SzIjXe1EhKf6byRvNfMDndK5cVKcuNcc6fm2/ILQzcJ+
	rKcftvEMFsP1CnJ9oZCf1TOc09v2+k3zQZzSjUltfpyP4zMRP7+HqS2KZLxEeLRQbofR95FAPGP
	UAvx9jNz8G992Q/UEawXTWDAZKXo2nwiAKSG1hWLCsGGUBjtxPnQ=
X-Gm-Gg: ASbGnct0KH0wRp6Uu04jTu6AxTTQD0KxX+r8HnFo0G77GvWVawlD/2nuU017DZatGYK
	I2EM0YOsZ8nnl0A/zgBVlaL4sfhmkYWpHZLaCy4FZsI23XjqWc4SN76dawzUfau7+iYT1YlEyvV
	T33E6NcTzQkD71JNuOF0bQKZjoKm6j8X4RN2lK4EOJphKgWeGTHOtujfYy3JNv0l3BubjNigTtF
	4BTqjI/8QfB6i+Hlamqa/ufJo0Y0d7qs/mudJoEkD4fLEJYbJjdNmSiKnXwQM7bQNjSHCQ=
X-Google-Smtp-Source: AGHT+IFuEHxUGZemG3Lw6GJyJiLKC7kdvwsDE7oXb+eCceHLIabTEdGFPXVSAMyPTApNPiB9m/aWUBtr2KPwWIdbru0=
X-Received: by 2002:a17:90b:2d8b:b0:341:88c9:6eb2 with SMTP id
 98e67ed59e1d1-3436cb7be69mr12345464a91.1.1762819945887; Mon, 10 Nov 2025
 16:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHtS328bOsw=7u0sN8P0F7Mj2xo6HCQLVkZXMBwp3rqTrAY-eQ@mail.gmail.com>
 <CAHC9VhQw2yXuwhVSZERXiOREXzuO7aU=LTUiL1go6v5m5sx3Mg@mail.gmail.com>
In-Reply-To: <CAHC9VhQw2yXuwhVSZERXiOREXzuO7aU=LTUiL1go6v5m5sx3Mg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Nov 2025 19:12:13 -0500
X-Gm-Features: AWmQ_bmyscMBSBBrJRMsIWWyFRwgwIczbA-GW_VHcdp0Jr7CgCsNi7kMSHpcKbQ
Message-ID: <CAHC9VhSEopz-LppHfNrvKk0KjuoQy-E8Q2_tAteBKrxhJ3Vd_w@mail.gmail.com>
Subject: Re: [PATCH] security: Add KUnit tests for rootid_owns_currentns()
To: ryan foster <foster.ryan.r@gmail.com>
Cc: kunit-dev@googlegroups.com, serge@hallyn.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This time with the proper LSM list address.

On Mon, Nov 10, 2025 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Nov 9, 2025 at 8:13=E2=80=AFPM ryan foster <foster.ryan.r@gmail.c=
om> wrote:
> >
> >    Please review this patch that adds KUnit tests for
> >    rootid_owns_currentns() function in security/commoncap.c
>
> Hi Ryan,
>
> In case you haven't already seen this, it would be a good idea to read
> the doc below on how to submit patches to the upstream Linux kernel
> lists.  For example, sending patches as attachment is frowned upon as
> it is difficult to properly review patches that way.
>
> * https://docs.kernel.org/process/submitting-patches.html
>
> If you are having difficulty configuring git to send email, you may
> want to look at the "b4" tool, doc link below.  One of its primary
> goals is to make it easier for people to post kernel patches for
> review.
>
> https://b4.docs.kernel.org/en/latest
>
> Good luck!

--=20
paul-moore.com

