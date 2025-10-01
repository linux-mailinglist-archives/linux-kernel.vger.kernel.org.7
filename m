Return-Path: <linux-kernel+bounces-839433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B36BB19AB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CD47A91DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2CA1DF97C;
	Wed,  1 Oct 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxhiL04T"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11518266B52
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347136; cv=none; b=Inmds00BFaSAuyhW1FvSj7+y+8n85UNtvN28pMB6k0nthBT+KizYW9RBpQHRMRedXcyeiBTV9SeYfe/AiQR+9cEEUj+1J1LQU2YLBCqxyO8Uu5W3Ar0ykVDjBcVcBCiFFBh85aEYOK/nFxMYjv47BiwZfxtXIbBekcBlndm9b8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347136; c=relaxed/simple;
	bh=AB+3ZU/r4mmFjziMeNnrw8jJOTXW21ulNp4jswpIkxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gi2iOL40J7bXbxJtcyXeNEh316DqII5O6G9tNYzpUi2XxaVHQOxb6nRcKGmBzmTv11yhbFMflzcL39uIqw/m1Q5M/O3W+L3bznZyBGKECnLOr9C8U1kQrvuUi6rAf1zbSkZdIAmK1/q4NpDwgUBr+ut+xGbuFvGP1z7GHsXKDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxhiL04T; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54dd647edcso181325a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759347134; x=1759951934; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AB+3ZU/r4mmFjziMeNnrw8jJOTXW21ulNp4jswpIkxE=;
        b=UxhiL04TXY+Prdg5H4W3+SwtG/ecdB0PH4eI8q1wQSF9nwG7BXAmn1TIf3Zh3otTej
         a+XvkGpQY5uUH+2M7J3Da1rvroLpPo/PRs8cerHZfEx8HVGK1Q++H/AVLqzu3S1rnP5y
         iEP9MOpV2QThMj3C8Dq0/qZn2PL8nzq0W+QA2kfcD3vNbp9UcfnJgJlehnGvGyOu1r1T
         XHG1V7Yjy/siexR2dpaCzVSg+ikp3uVaMEjcWI56gt19aAjm5aizP5fDdivPyUKPzQ88
         KqLGVYUcXlrE7XPgzx+yKnDPVYU1f/3u57htCmMOqfdmYP8COJ5P/0/oWPye20d7o2mV
         wNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347134; x=1759951934;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AB+3ZU/r4mmFjziMeNnrw8jJOTXW21ulNp4jswpIkxE=;
        b=D4zHni/aoMvviYWPOiP/lE60NoQCfjRjRs83wSwj4rTDh1tnKhxfZm9JBUFQnlsk4U
         DoiKzrsyW8lMMIStyuz/C1yOmzPa1qU4QRHC0c4sBLPLvVBCvFLMFZiYZ1UavkOoaVk0
         B/bS/pDP80zeddpyF8VL5QtZG/zJzwLG6ineqC68gDVJrlmqLVVt947ynZQ+G+VA7vqL
         D9VA5rGmx2RbFnO4JHSt1vD8e0auk5I2PLh0MgTBaY/dlhmo6HXDmCzSq4dAhjMIK+58
         rsPR/61JjbNkEprC38mRUKzOssDMWgf3GS2q4kiOtOmV7rNfN4YQLvsADciW41aCMb7n
         wjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7l4XiWl/BOFuWehYOJKeBQEHDyYKt/GfkFxyrvRSzsau9b0wPS0WWFC9S4/q/hF6Ra8UKigykG1DqbCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Uv1w6ESiCOBJeuYpYIjqyso/DwsRJgCCASWSf6ikF+29V5Gw
	BqYz8p3MUV3vqZ1vQDC4S+XXQX1SZ+X+CnXMQqBRq6Prc7xYqFVSSneZ
X-Gm-Gg: ASbGncs4EjV2401vLYuIwb3+OgrTJpJtVY92au31dTz27uSY0q/jcCKfH+ua4rSj29e
	RF4MjKNKkKsnq6w89KlOwsaZR28cg2jwVCTlW3d3s4bgXIXvkifWrh78AspV5Gn+IFaDtffRm6o
	7OTrF/GiaGvw3qO+6JFUQa9/ZPmOYyZmh91wzJ1CPoOiwcQ1G8wBKOEXCsVZ1gTlLJho/Flzpk4
	fLX+mh6pUXF1zaQhV2xWCHlJ4DEaJJxiRtBfD/e4MAtSYVOl/5w912s8cnudmULTN6Co+tKO1z5
	Mi6kWp2BzODax22br30H70R3u+lb4S6ESdpVOvzOiELX5mPzkxyvzRhJBVTHsoreFbF26GQfJbv
	9uWO3HK2B/3fn58CVUzcAcRCrrx9D2y4KGCtGfBLzVJW3ym6yO9+hzmOJNNWK2qZfNi5l+Xs=
X-Google-Smtp-Source: AGHT+IHm8zVw7hCRgUCJVA4l51+UFyZtdxO/eRTnE+8iXurYGow9Z2GDIKZPCQDTJV3ZwB4QbFulhw==
X-Received: by 2002:a17:902:e74c:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-28e7f2a11f7mr61532815ad.6.1759347134292;
        Wed, 01 Oct 2025 12:32:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d95bdsm3640625ad.119.2025.10.01.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:32:13 -0700 (PDT)
Message-ID: <8f72a29f419377ac9e3ddd7ae56bc1e0826058c6.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst
 is a pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, KaFai Wan	
 <kafai.wan@linux.dev>
Date: Wed, 01 Oct 2025 12:32:11 -0700
In-Reply-To: <20251001191739.2323644-2-listout@listout.xyz>
References: <20250923164144.1573636-1-listout@listout.xyz>
	 <20251001191739.2323644-1-listout@listout.xyz>
	 <20251001191739.2323644-2-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 00:47 +0530, Brahmajit Das wrote:
> In check_alu_op(), the verifier currently calls check_reg_arg() and
> adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
> However, if the destination register holds a pointer, these scalar
> adjustments are unnecessary and potentially incorrect.
>=20
> This patch adds a check to skip the adjustment logic when the destination
> register contains a pointer.
>=20
> Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd36d5ae81e1b0a53ef58
> Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")
> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

