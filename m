Return-Path: <linux-kernel+bounces-862668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861A4BF5E16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E374425332
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF332AAD2;
	Tue, 21 Oct 2025 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UMMTqj9H"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3E2EDD53
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043812; cv=none; b=RiajpIfbKgG+8Gpv5rBwx+WkiH75brqHVFNIvgGE3kVWgStg7slRGlayiaCCXJqG0R9v71oHX5fzqYUunA5RDdCshNHZyXP2v4o/I1V1JFzndcVckbNO6v1lz3BcvZY4dGUcxmYSipzj8JL9hdeoL1BVV4qtOxUTF3SDlVgLkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043812; c=relaxed/simple;
	bh=tibOHuElsdn98IyG9GdCHJwfonoWwofOLVF9QyGZnAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rj9r2iNuizQ+1YDenFjJDfDjVEWHhJIA9hkoxMi94mzQLZ41+YqVULv2Dqe2Kj0t8QqMZJkc4OzPOLVZzmY/vltkN17IKeYozK3XK39r6Ih8iMNrkzOzozfX/vp42+EvaXpRHTARezivyPHD/xfYAWBXcU9Z8r2lFr6ZkgYbAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UMMTqj9H; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so5297674a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761043810; x=1761648610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5mx/neDnkeSOkePEkm6VBEHII9lIyY01G34R6H9ZvHM=;
        b=UMMTqj9Hy7W/mc9pJK+Er3vEJEMR0TZ6k5cZyTAAx58xGM1Xk3K+iUzqcJST3qBpJJ
         onR6q1TZVpSSU7SQItNbmNTls0MH7vkvSunbU9k0bFNsoZo82AYnOGzEk3inXo9ykQDR
         qlMA+4ntnG1aHbmgEvgOFapQAoH1zsOe57PY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043810; x=1761648610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mx/neDnkeSOkePEkm6VBEHII9lIyY01G34R6H9ZvHM=;
        b=KP4n6j2Ph+fzpVf+RMc7M6TyYBVUV6f9+BPyGjN1Yr/TteQaBF4XTahIO92cGzX9Zq
         aO9tG0dZm+u6hJ9z2mZm9SrChlO7nGZKRgsaCyQKEbq0nfWeSXoDUayWEwpFCIc3srd7
         UMPNbT1o8WPOJbOvmMILjC47EKI9zMgwLRLINOHAcZzGijFPBqWeUbXnINXJoGMA0W5Z
         4S+qkZYZw0Vc1ry8e+IMemXhpYRRNaLbsycX3c6rrPvIE3Y26sHLZvOTZEQzg/kXP+yQ
         x0OEjGLaNdowgxJelYvQKGazyvf1X1WWz+fNOF7nEl0l0nRpBRnz+rZvo5ysW1Xe8rDn
         JmZw==
X-Forwarded-Encrypted: i=1; AJvYcCVqHqI0EZD3wiDYSk9WsRQOmBSa7jSd3ZEnss3DvXmJR0m8yrUUhdhBXEiSf/S8T7u1rW3clBlvER7q0r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74FmmVN+Ii0B3rqaCJneGN700VSQ2vpoLiyBRBCoDfyJx6eVS
	t3xhLcAtzMogQxKHY3AUGL83OywHuIeXTaoesp5eteoIpsP7hqXZIksHFNT08T3oZa+MEtYetNc
	lDVs=
X-Gm-Gg: ASbGnctQ1/nqVFByABxxdJdeWNLeYoC1p2er77lQQw1FZZWD78x3Z4YRoC8p/Rs5gMS
	fu7LylmdMD9jl4gVKMi+n6eXAwlmY8uFvjeMu1wn8HnQksZN1O/haTZUMqrdsvHGVliuqrIyy8h
	GKWpZCELzUqFtPD6ugemaqW4iffyHylSNnOlPM69dxfdhias2wL7ZprjPGNB4alxcOAhT19VHJz
	LUd3VV70Q9dzhs7BbDB2AhgeZwnKZWw83mP9nQtqtpx0zhcCYBBymihM5yYGLrruapsD/kcIt3A
	1aPXgecUu1Wc4vgWWe7lziBLfOU7PWd/anBRxOwNN/kJ6x1/uvpWLEjasz67WJHKY3j2UVTy9Gq
	Vye6HMWe5TXUvpi18Vslc+S051y9/MbFVLz6IHWh1xpTXRu6ASBRIFqQ9n5FU4bGiyCtdMHElJy
	jWt/1cyu4C7nCy2IYAs0fRl7W7/zJUGKJ1QHKEmOdIUh3XO8nsYUke
X-Google-Smtp-Source: AGHT+IGSF4cVLU6og8Bu1VVHlyFUalRj4InfbphCFlUmZe8uXqvpQX1kQvEHmKrHfvt3L1LS1RTAfA==
X-Received: by 2002:a17:90b:1b4a:b0:330:b9e8:32e3 with SMTP id 98e67ed59e1d1-33bc9c0e75dmr21140713a91.12.1761043810196;
        Tue, 21 Oct 2025 03:50:10 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8091fsm10780315a91.19.2025.10.21.03.50.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:50:09 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-273a0aeed57so80096525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:50:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXb3B1C712VtPgCkqf0utUd4Or1rBYOi86Hx5uOrdEQQGpHKl/0M3xKBrk7nQ5SdkVvfQ5dwlqLRzkfW8M=@vger.kernel.org
X-Received: by 2002:a17:903:8c8:b0:269:b2e5:900d with SMTP id
 d9443c01a7336-290c66da7c7mr197621385ad.5.1761043808846; Tue, 21 Oct 2025
 03:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-imx214-smatch-v3-1-2c9999efc97c@chromium.org> <aPdPyc6Lasmp3EzC@kekkonen.localdomain>
In-Reply-To: <aPdPyc6Lasmp3EzC@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 21 Oct 2025 12:49:36 +0200
X-Gmail-Original-Message-ID: <CANiDSCukjH51Gi5S3ra6Jm_kPWhkrsTPGf42DurC1Mvrd3XMnA@mail.gmail.com>
X-Gm-Features: AS18NWDdcIC1YbprgDnT_wuE3AKXtOoVu1iUuwaBxos__XTSpHjlvHJQCCjcNjc
Message-ID: <CANiDSCukjH51Gi5S3ra6Jm_kPWhkrsTPGf42DurC1Mvrd3XMnA@mail.gmail.com>
Subject: Re: [PATCH v3] media: i2c: imx214: Rearrange control initialization
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sakari

On Tue, 21 Oct 2025 at 11:18, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the update.
Thanks for the prompt review


>
> On Mon, Oct 20, 2025 at 08:18:13PM +0000, Ricardo Ribalda wrote:
> > Smatch is confused by the control initialization logic. It assumes that
> > there can be a case where imx214->link_freq can be NULL and ctrls_init
> > returns 0.
> >
> > Re-arrage the function to make smatch happy.
Re-arrange the function to make Sakari and Smatch happy :P

Best regards!

> xhci_hcd 0000:09:00.0: HC died; cleaning up
> usb 13-2: USB disconnect, device number 2
> >
> > This patch fixes this smatch error:
> > drivers/media/i2c/imx214.c:1109 imx214_ctrls_init() error: we previously assumed 'imx214->link_freq' could be null (see line 1017)
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> --
> Sakari Ailus



-- 
Ricardo Ribalda

