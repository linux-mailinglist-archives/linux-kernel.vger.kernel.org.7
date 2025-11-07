Return-Path: <linux-kernel+bounces-890667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC223C409FC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E991A42C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E739329C68;
	Fri,  7 Nov 2025 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FZ/RnJ6f"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7332B996
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529840; cv=none; b=IWpWhJdHb4xOCZuTihhoq86Jf/9Z7lhjNGiqsAwLcF7oGjeH98W6MPJSU1Q6pwZlIzh6cfsJJD3SiI0vHQjOjUHM688jsx3sV9w3M7g+SrxW8GNFcHytkUkBtjlnVJ/hx0PyoGJ/0mVP1/Jv/kCtmyj7hogx9crsoglCAaxyW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529840; c=relaxed/simple;
	bh=YAtagVcx34LiTu2Em+AG4zrD5yn9L45QqXjTBIFCHBE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boH0DfRD5KvpU82B9ulJxscGMhUg+SRyK6tk6Al1avpd5BgJLNfqQrk5VU6s9NpiLHBWxfdgphwBYF+FI331aKgky0cesMoo57bzWmMUH5+s9WDePVBSph53671jtalEFXpcSbRCnNdn+O5dINymkoJNOgPMCIvwDvP+oR8n8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FZ/RnJ6f; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5930f751531so874976e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762529836; x=1763134636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTtcdT44O12GZqFLnS478W/Jpk+0DJ3d4h0jXmuqd2w=;
        b=FZ/RnJ6fWpPxXrB2+fvFJJZde+Vmv7M2WbHBwXXnJsLl529BoFWAb/F6fQUuE1SMkG
         EIDp94UvQU7xiUsXn7yVYAum3qPN9Tug63tdpkbry6XmHbMfgBXeBA3QgUza9AJrt8gr
         NTC7yy01wLjCDZ0AHLPZcSIB+LZckQIF7HRckGGC7cKh9mj3kwz0irNlIHEp0p0MqzsO
         tbHrFwWwjeGJQSjNn9c2wNbMD4S03m+6QSp/6EPzr+nebdXVL7fJ/t2V2+JBDWg+U7/w
         nYKQncAVBWHvguzUVBU7dXgs4mr1Qt6Ttq5uffS4VjbqXz65x8VnMoGmSsYm1vJkMR0v
         g/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529836; x=1763134636;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTtcdT44O12GZqFLnS478W/Jpk+0DJ3d4h0jXmuqd2w=;
        b=OvRxYhswJTqUBv7c4bE2lCYvVZTeJLaPwTBAGtXKUFpwuQ/ve1wnup/WFH64Fona8J
         smBo8QJStlRcf/djkJ3ZP+ZeagXpziv2VHge5H8BMeTPA3ggTdfl4o6hCQFTfiYr829p
         jcEC/mpqJ1wX8cKmPraaFJa8tt5XEZ4+/ip1egPwoUkIHI10sAGmRREPRxgbHsSj9qgc
         EEVFgjGmof+l8QMGxOzXmfdPwEUIkwyIgYuigP2Jf0kSLkG59ilom97He5NGBN4jWgZa
         i82GArgga/IS8r7vxjR2SVLa8Ip+kBELK4DNTW+8UbzGqFFOgOc0F/3jyw3qeLmDp4z9
         8Ekw==
X-Forwarded-Encrypted: i=1; AJvYcCXKaYaGUC+MNfmrH8xTbzb9y+PHezF/4hJDsYt+WqgmQ9PhBIeo7Ae1w2MS6O9WrvnBADGeeUuL8u4CwGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQao0a6GUJiRfRJohJODkau5cEVRMIDZ1qrOA+PTWJ+NMESbD
	Bm5mSFLRZyNQGO9U+Pqmn9Zeh5Vy2WDF9UkhRFUvXi9tlQhQ5/lxqbRS/dWmhM16FMJhphKrJ1P
	sTpr7sm9lSfm1EqTvt/aOOvVmNFMZ7HW3UVsUo6zQBQ==
X-Gm-Gg: ASbGnctB/BzHU8BjmAQ7wrPj4nVTxU9AgWbLD46MzSt3ctWwi4DMW1j55kRkCgz06Xm
	KMsHsUu20bdI8BRHHHfzZ4esMKntKJ9Me2g4dAO5KGvPNVPYQKvP+EKznhZ58OhwCwzdzIhsxix
	s9MWO8YmZc758gQ8/FAluk9qwbWwJvJzk1Wx/uucj9jGkIXPmIFuUwOlCPFb9+ZvDLCx0PGMsuh
	OavuOslCjnHkAcmuk5trneErb4fzIk69gRFD1COBfVF2bvkLx+69RUMnCs6zT4ZqvldFZqpR5AO
	CkGvhFsqKZ/7x1o=
X-Google-Smtp-Source: AGHT+IFIQWLvyizEJkA6WQQPfls6s2Ke/GDQq2r3QKt0gm0TI4N21r92bi9oP4EBFVG7CQqpb1Qa/kmwxqVMsaEgQbA=
X-Received: by 2002:a05:6512:114f:b0:57e:c1e6:ba8 with SMTP id
 2adb3069b0e04-59456b689ecmr1167747e87.12.1762529836073; Fri, 07 Nov 2025
 07:37:16 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:37:15 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:37:15 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
Date: Fri, 7 Nov 2025 07:37:15 -0800
X-Gm-Features: AWmQ_bm8xW_kPpRTsH9WNw3ymMoDp75e2yehSkvO8IUPn-NE_tXci0xOQuXb2kk
Message-ID: <CAMRc=Mce4KU_zWzbmM=gNzHi4XOGQWdA_MTPBRt15GfnSX5Crg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix SSR unable to wake up bug
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	quic_chejiang@quicinc.com, quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 04:39:22 +0100, Shuai Zhang <quic_shuaz@quicinc.com> said:
> This patch series fixes delayed hw_error handling during SSR.
>
> Patch 1 adds a wakeup to ensure hw_error is processed promptly after coredump collection.
> Patch 2 corrects the timeout unit from jiffies to ms.
>
> Changes v3:
> - patch2 add Fixes tag
> - Link to v2
>   https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>   https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>
> Shuai Zhang (2):
>   Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup
>     during SSR
>   Bluetooth: hci_qca: Convert timeout from jiffies to ms
>
>  drivers/bluetooth/hci_qca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

