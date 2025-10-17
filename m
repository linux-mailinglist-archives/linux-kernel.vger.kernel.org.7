Return-Path: <linux-kernel+bounces-858291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D23BE9F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CF41589137
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766383328E7;
	Fri, 17 Oct 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PDFSrKBf"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397932E13C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714214; cv=none; b=LGr/vXB/cWln9jWnuwG6iep2ytm793VwtBr6N0B2LQWHfMrzF7O3cZbxG6Di5Qh1rp1t3wPWLwFJTZkrrtF1Jv27bqvEztwbeZjdqpl+8V01px1Hdc4NfRh5b62QRgB31mMNbPLIPnBMLTLAmGJ3IGI/kRbYPWrjjg5JZRqRVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714214; c=relaxed/simple;
	bh=zRzCE1aOx/xulGdt40gbRwnHzDqXCXfHAVrjFkhrJKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIqs55SDmjKj3ANsjZoCd9ZvVZNy9oAhNDzq7fT+7f/7BpDW+zZUEOflsrjRUm9bnOUUF2cvnajLCo+S2xoYFrotqyTVY5rceFdAqS3ZSrHtV66DpVgxk/NS2s7bC5Siead2r6JHeyk2fhVH7qk7PR5kr3PT2INckSJzpl0WUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PDFSrKBf; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso398901766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760714210; x=1761319010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Yt/6++p05sAqYj62fKBAZskAYW8+TXhBVJRVFYeOPc=;
        b=PDFSrKBfUdZmYyaRzuOOT3PCwjK3u/S5/NvWHBOWl3nYuQVEnbvCFTBa+/rEK7PPZk
         3TfT7bOQTynpqP4lcXg68DaSB1IpUL3pgzqFixBk5WIozWBG8XBv2X+9JSiEBJo2mnvz
         yprU+eLv4IsHrh8Qc17cWdlzPkdkkEp2aZmYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714210; x=1761319010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Yt/6++p05sAqYj62fKBAZskAYW8+TXhBVJRVFYeOPc=;
        b=mzNm5WfKDJvIn1nAYnDxciLAdhV1Z1JlGaYr7SKqz5+3/RDgsqVAC98Tw4FXuqxXHD
         Uo8s3sIDKw+O07WieR9/N87rDdygxoojJsHMSnrQG0JuZmwvuIjCiXRkj8yNQ43PUqX1
         zaoRhdx3pLjTgbh2JvZZQnzQ8kJRjQM/m1c4Nde2vb3oWP+3Xyr1FnskQlRuOGZjHVk/
         eKgIcJoihGShYzhcybrAM/HVc8yMcUVl//IE27pVq/Hv3f58ydw3Eq8hdbTt8tq5ZmhC
         vqNwA+qCW1YMYiXkNZAr30e+2xG63XfJl3wRbIEAUcuIPPjTeyWFHTHpAElSYGsq7ich
         zbig==
X-Forwarded-Encrypted: i=1; AJvYcCU8lgUg07BodzcEyMqIJGJGUMxCippzL+ArEOgGdeqyaLtFh4lzvF3/VBmHZAnKQTc1ltXZrWjPxVIfG6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMB5DHM0zifMN1MTXk927BP+6GdYTG4pCjXzDm38nAxlxHda55
	lisxw8n1ytP4349a/hrm2ltLUtp3xUIaLDJ0upP9CEjR+yc1Nbqam9PUWgpRMQ8INePIGVfX7M0
	wZrIgRz8=
X-Gm-Gg: ASbGnct5Yfbi+R+9HaiYoAMlUksCy/b3sdN355DvJY3teoDA7163vUHoxUcpYdTC4dy
	z3sqwTOluSDaM6CRBJCRgSoU30+K9royR5PBY/vqxZB+YYHZesBdCX5R8LKLvuia1bEdWp4ahDA
	Ew7EYfxOqI2SXwYMd+iYzUWYoEYsQC3NDPRtaQXm6u71Yuup3MCK767KO+MUh7MszaD0/+Qs+N2
	AhWSh94T5Vp2GZ/zykOr4FIEnYWwZkacF7WNNKBkL++X0V7odbeCCwPWjvt3e8C2PEKkUDpQupX
	PwkgEBNLV5PwVoVUdkICg8tlKgHXBC+NIbLaaLMSMA3dTKV0Zb7Oizgh7aF/4Yp3TGBpjRmIcFT
	vNSf1zuY3S1tMk7EEmDNxU6MeJJk6Bh8APXxNbXumJASqcB5MpMk7sCsaWDe2W4MlqteRyyi1Ba
	DPbihSlFXbLg0aCmRzeUJeVJMVXeG0DoXOEi84Arj3Hn+D4jAnto6tNiiS78YXr396UpxTUXA=
X-Google-Smtp-Source: AGHT+IF7OQPGbx9WRDEBpX02QXRjWrwgPXMQhQFH0t/7311eW/sZZI6CBrDPDih7YL1E+TlQEMjOIw==
X-Received: by 2002:a17:907:c02:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b647195b322mr452611266b.8.1760714210340;
        Fri, 17 Oct 2025 08:16:50 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1af35fsm833116366b.60.2025.10.17.08.16.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 08:16:49 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so2810327a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:16:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2HaXdGTIlM95CwdG5i/J5NnxMlp1sXhwrvay/cQT5QistlBcDCkrjdzCZIVdWCfCsbRLdSVrjSB8WbSk=@vger.kernel.org
X-Received: by 2002:a05:6402:3552:b0:639:e30c:2477 with SMTP id
 4fb4d7f45d1cf-63c1f636789mr3814749a12.7.1760714209178; Fri, 17 Oct 2025
 08:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9ty=C+PAgZD44Y_LkUuKkRtLFGffjX9rZX8=fkP0s-8zSg@mail.gmail.com>
In-Reply-To: <CAPM=9ty=C+PAgZD44Y_LkUuKkRtLFGffjX9rZX8=fkP0s-8zSg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 Oct 2025 08:16:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7wA79sTZVEefX1BnBJEpYynkNcO=3UPEtmuLb5UJ8KQ@mail.gmail.com>
X-Gm-Features: AS18NWD27yZqWzRWvknziV1Hffxqvxsliqx3FofccoZTWL7zymMKM8Rfcs9vL0w
Message-ID: <CAHk-=wh7wA79sTZVEefX1BnBJEpYynkNcO=3UPEtmuLb5UJ8KQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.18-rc2
To: Dave Airlie <airlied@gmail.com>
Cc: Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Oct 2025 at 23:14, Dave Airlie <airlied@gmail.com> wrote:
>
>     There are
> a bunch of stability fixes for some older amdgpu cards, but older than
> yours.

Heh. The day before yesterday I finally upgraded my old radeon card,
and from now on I'll be sending in problem reports if they affect the
Intel Arc B50 Pro instead.

I'm on the road on my laptop right now, but once I get back I should
have my new monitor waiting, so I'll finally be back to a dual monitor
setup, because now I should be able to do two high-res monitors again.

          Linus

