Return-Path: <linux-kernel+bounces-886926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6C4C36CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24726503CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480C63328FF;
	Wed,  5 Nov 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcB+7zNm"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8E31B113
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360195; cv=none; b=iyRg9O/F+3OUWuMuGRtDOoEyGf0KVuzlNFdQIMaezqTB1NOC49bF2t4C5DZqfBA9K4R0cqGM72sh3ePyOWM46QBQwzzUcfXVPk7wd9KLiLV2TBU3gmtfnGcPUzRB3asdGjQcrZuJiNlX1xNLeBW0AFYCXeV1qcYw0sJOv7fVYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360195; c=relaxed/simple;
	bh=jkgNn1+4jXuwy+ixaN/rtdNFuxUuVeolHm9PhEbPJDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quNHJQJy1NUcTfmltxZhYMRs4AH8KHKYIeIDWVOfaixwDPZBXjTv1Tru7OYdrWN1wA6DkZtU9Pvq1rduHIq/S6CaqyJUcYHU1bwAfXgL8AS7DL2vfsD03ONJUDGE7k9otCplKnDmQLl3lo4gMQ9SnwSwVXKc49QgVCLYLwMw9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcB+7zNm; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so5838071cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762360193; x=1762964993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkgNn1+4jXuwy+ixaN/rtdNFuxUuVeolHm9PhEbPJDw=;
        b=mcB+7zNmAFbFw8VRbC/5zhE1reiZfvmRLnX/FHGT9RcKwHrB1V2sVLz/HGvA0ZI2G7
         lDaGtoyzA2FdHLSmEGtHSQ40ewjPTOpNIU4Eg9hyWFXqUjFhQp+sKAUbWVLLFxLeQ8+l
         Xd30Rd1UHABTEtqgrm5ACN9nQfq/m/gdHtKG9YIw2Bv8Slql1g/SEvcnz9jM530P5h7W
         b2ulslLTr+nvLikQCxZRvbM3Ys+Z/SQ1srmDTc0FqLVrC/HbUKdf+/yb49nW748lyg6N
         fj3+U/0pIhWcvXokkMD3es1g48bxCn0LuGRXNXYzWPBoAqCRgawExIMoqnjL4jqVT+9W
         F4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360193; x=1762964993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkgNn1+4jXuwy+ixaN/rtdNFuxUuVeolHm9PhEbPJDw=;
        b=r+Y3biXPqExuglFiY1a0UqLDBbHQQq7qnKuz1aKmVPilt2AqhxxQYstEeKmnMBWGuH
         mX7z4ybbLmB6Z/N/VmYFJxYOPS5Z0eB+DxJAl3+8C36Tl1vCElS4XY35a0srzdRmDsW7
         FlosjSvpMTIWGskTj3bHo/3NVVz2mqGofVfEvEcDYyVTshqRIDJKOJNsFYRbuSdwwpbO
         nCj0d0gjhFdfS8654jwdl+85QW/uNf2fJs2cIgXCcrQlcCVZ5e/pP/8+TrMGSCj7qJ0z
         r0ZDIP2Iglp7sLguYCv1YNKjO9axYLeAkd357YaIikviCx236Fs0NxjToWiq/vmc5a2h
         uCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiS6upfZIpc0S7JWWy3wG+JpHVFAu2sTkZPUrgS5B5c/Bc2AFHfY5dxwljQTIfCTEDnhJM/9pUe+JUzyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBK2YkOEr2WI4Cig6D/8/8gBXvasqQtjMKR3RyerXkszXS8D5
	fMCK83kndYHFzm2lJKqtfB0nRN3S0m2q2QuFD9iIQy+4mFw8ONhtPsEZBAkoVZg9ha0iNA/5Fck
	xvV4m+V4jBdCrihhWDoBxCULtTGQ9iIW7A6GzqzEM
X-Gm-Gg: ASbGnct7vUtvpAIniZhAVA99iaRx7haXUrAvDD5fQtT+ZeP2x9U5yE8/nMEDD81ZAR+
	nKByOfwrIJ7bYRq9Od5R0UM+OnN8M+j7nHliFmm4vLkD9vOMPQfCuqWUSthD6/dHci3ibHlz5rE
	/CP/F9erejWpue1BQJhDjb81UbuNC5bytET8MhO1IObmADVexLYFZzwtxz+CH9DHctRZFYmV3DZ
	Vcl/fVMARS0Bzh2bjF+bx1As6MDbbmWyQrIP5XQMKK4PKa88JB6RKVA0W3RlQhM31ieM28=
X-Google-Smtp-Source: AGHT+IEIZjVxK95nJsAKgH1Nu820ZsQt/RsaIyZg90c7rumoFU/fQN7xKpn07wzaK1Nz9W308QqU7P8ohGXGb5TtlTQ=
X-Received: by 2002:a05:622a:1455:b0:4ed:2f02:ab15 with SMTP id
 d75a77b69052e-4ed72602641mr43913211cf.55.1762360192504; Wed, 05 Nov 2025
 08:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com> <20251105161450.1730216-7-skorodumov.dmitry@huawei.com>
In-Reply-To: <20251105161450.1730216-7-skorodumov.dmitry@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 08:29:40 -0800
X-Gm-Features: AWmQ_bm-inBtiHZ-i-Ji7OzkBeuhYj48CizrYi-xeimRs0Xoxc8_UArrOGxV_kU
Message-ID: <CANn89i+iq3PVz6_maSeGJT4DxcYfP8sN0_v=DTkin+AMhV-BNA@mail.gmail.com>
Subject: Re: [PATCH net-next 06/14] ipvlan: Support GSO for port -> ipvlan
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andrey.bokhanko@huawei.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:15=E2=80=AFAM Dmitry Skorodumov
<skorodumov.dmitry@huawei.com> wrote:
>
> If main port interface supports GSO, we need manually segment
> the skb before forwarding it to ipvlan interface.

Why ?

I think you need to explain much more than a neutral sentence,

Also I do not see any tests, for the whole series ?

I have not seen the cover letter.

Also you sent the series twice today :/

