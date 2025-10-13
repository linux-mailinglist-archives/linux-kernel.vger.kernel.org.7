Return-Path: <linux-kernel+bounces-851371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB33BBD64CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9928F4202F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345952EFD95;
	Mon, 13 Oct 2025 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3rf3i6I"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BEA1E9B0D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389020; cv=none; b=mT1WYFalgCd0QtP4Vse1lzztqGpyoDwT8VOlCyJI/ZzASi+PVaTXejuUmX0f5ILSmYvnuq1kmB3zOqoDxpXdLNH21iSfR58bXQRCUOuzQCmr1Z1C/+nYWuG1+Hityuuzc+0+e8b3sXZ1CErr1dVI/+sEmK7sUObRbHTfj2nuRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389020; c=relaxed/simple;
	bh=OyHiH88dCYxYwp7WHWkEWZwQO/x9OpCs5mZ4bjKgNEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/cYArmcZXgpx8Q+saMRuKXgRdxaT5tWBIe5lPs7hDDenNy34hOCnov/XJ5N48K4YQ/jiMvSE+fD9GbVdZwZJVUT+oTjwGkqj4+L1H4lM3hI9wN40dh3Iy0VhorOAkzuMIq+269tufO6jD9ITgOqZr7IHMv/Kna4ZI80mNsDRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3rf3i6I; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-579d7104c37so5632230e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760389017; x=1760993817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OyHiH88dCYxYwp7WHWkEWZwQO/x9OpCs5mZ4bjKgNEU=;
        b=L3rf3i6I5l+ZQdWbOB85da8qGu01faVP4jmsdhHA1clYPKqIKMiS53LzDjtBOi5Qoy
         nkgpmu95OoEb1qrSI/ro+/QTnPYvU/WLx4jyJSTgnSrXzNj87246ekfqoNR317SXSddr
         +WG6rKn9csIKg2Avdk/4eGYo4w3zVHUXIkFYGTAa3UsZ+AvMhbYw5hbptxPGFnxsxDJC
         9XBpiQWOArfacWwtzAKGZuYty5wbc62JHEapXN5FcqSn/dxaW7t4msm/NAM1TeSOXS7w
         TrsEOogCDtF7gQS/NlkKIT8IgKqlP1aE8ao09qCJxi7XJQ5+43RKpcSXMLGM0hoGFVQd
         A/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760389017; x=1760993817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyHiH88dCYxYwp7WHWkEWZwQO/x9OpCs5mZ4bjKgNEU=;
        b=a3FzOtU/8//dfxMBNmloX/KF0qeeUqJUZ5QJsyhyHFBrHWZS5ALoQgxlBMg/pLmrX6
         LaPlypMytUJV1CkRgp4uwyGqqnq/QeqK7pMXsrUzySqbpITaSFSqlWOMjgwhvFj7CciE
         mAsh02RrRX/oUAwha7AP5HwfXvkEvwgl4rwpuhfsGzsFeFJUYiMcxixrZnzfFRNWBWuD
         RYa/EhN9hPXMv3OMoFRMphWi+W+DQw4JnIsjRyanHulY988y7xYEK3nmgPh4el8GUkz4
         peu/opJ4/YrwBsQsPrSjKacCTuVQRP6iowD0XCEBjw/5x1lja0LfMrU2oZQa5A7HFkj+
         sAOA==
X-Forwarded-Encrypted: i=1; AJvYcCX1ml73WkY064SWrDVxA121+PRoI8O39/0Rc1h88LCaN9vOuLnGGo0fEvab3RrxyXiWOjsWCo3TFQdcN54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo+cS7PwA8WZRGj9LubqXWuuJD9zmQkQk2yxXUCBuuMUcITvth
	7dQz8c8WdksHLNhYjQLQdqG3Ncmrux03QGuCJ24JsP0U8VOVBQp1SUW0mreDP+d+W/Uko0acwv1
	H54mwp4JlXPSc2fOeknVfi/PxE0N9cvQHuANy47Y2SL2IXX4PajaeBg==
X-Gm-Gg: ASbGncueHYBEjJKV185dg9Yt95RuaWVaCUG+9Ve6zAFvLkIq6YE69IeqeCwt8tGClqx
	sqhrySgFy7ysCj8lEdZQmZkQOIhZelpYruqV+5FQqetEfgTXoxbRGtp6CdJ9qpPtfKrbXI1xss9
	2mo+n/yPeZfzholNRehIYnheVeQGPcNcGEHV+r3MQp3/Tsd75w4e5G+e4/R3K2agJSGKkzobK6P
	8U5h/kIYyCPNRZrKPvLLN6L+HAWGMgLVZLzhruh1ptcfzebFZjXPXHV+gk6udw=
X-Google-Smtp-Source: AGHT+IGmVV5lrs8Ti+xvSM/oKnjUH0scqx7Ugbmdv684Hq14+QRlFYGp9dldJN7qQ6cXZcuxuKZ/UbiBuXuT8Q9PGmk=
X-Received: by 2002:a05:6512:114a:b0:57a:640a:11b4 with SMTP id
 2adb3069b0e04-5906dae5760mr6285581e87.39.1760389016204; Mon, 13 Oct 2025
 13:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <20251007000007.3724229-7-jthies@google.com>
 <aOZiuxDfwYql6ZUu@kuha.fi.intel.com>
In-Reply-To: <aOZiuxDfwYql6ZUu@kuha.fi.intel.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 13:56:42 -0700
X-Gm-Features: AS18NWDnCuURsI5Lz8cXhrSTClImN9qgumfpqgNkVL2-0TdBQW_-2CRK892lf2M
Message-ID: <CAMFSARd8U1RN10pgRXJwn4y64cNetK7isNWHgqrY6HJQn+LLtA@mail.gmail.com>
Subject: Re: [PATCH 6/6] usb: typec: ucsi: pr_swap should check connector_status
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Couldn't you use the helper ucsi_get_connector_status() ?

That work, I'll switch to using the helper here.

> Maybe this could be send separately? It does not seem to be directly
> ucsi psy related.

Sounds good to me. The same issue can happen with DR swaps, so I'll
also update the patch to refresh connector status after sending
SET_UOR.

