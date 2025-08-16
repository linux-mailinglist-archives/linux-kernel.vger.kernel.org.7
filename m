Return-Path: <linux-kernel+bounces-772183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C2FB28FA8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F30FD4E19DD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9B2FDC3F;
	Sat, 16 Aug 2025 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EI+c/A57"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D456149C7B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363389; cv=none; b=sbb5cS88odu8vcYLnC16WUTE+zTIUqOwWFT3LUs428bW02CjNoQqLtTck0ARs2btfW4bO7KtSHe58SZaC5DWdi+nHNHi8inb77Hjbn9/GA+kThsq/PX1iYGP0HqCjOBhXe4zFeRkN+MHcGodSNNSEPK5PzZI3r+WdqNMOyMDRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363389; c=relaxed/simple;
	bh=woclP5+jEBRau2wQUGhcWNrJqopsedVvlkWQeccJ4uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XOqpRP2jPD9+q/zGmjIo8/vEF34p6GvpBGU87rFVrWR0ihCkMn4vU7Qie43tEZc9WyIIcEdVFkMBIo6JZX3pfcj3mfthoYsWmH+CU2e9CVfzPnHeRBjiFOInEVQ+dNSJ7xEpQ+0XkAvl/iHPoqnhcArh+DIjtZg+FR3S8TfaRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EI+c/A57; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61bd4c45957so1523018eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755363386; x=1755968186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbRjZf6ZRf2jst0Yfan9jOOyyn6yhDJByZN4z1KAmss=;
        b=EI+c/A57kEDHsOpVRpH+GTuod8FRe7y0k7USltKWAwuQloU6Bq/Ynd+kVNzCummFbX
         CYBIwNtj/Ff1tB66PTfpMnIqxcdr0VPLRDyaepAQp4OsvWNQ6S1HA1lR/iajHJ/5A1aE
         g1XNZjYL+q5ugZQuK239u/B4oAH8lkBTWTPj6HY380zv9+DrB/0CppN+MT5osJG6qs1K
         hej04tU2g8R6BB6Upm0VHw+G8P/C8r/9ANjJqTuW4w98kuycxGa+Brk//jUIxzU1aEp9
         zgh0rSSX0WkcreiLprzPcPHr/3F0RJ2RjoE2RWNW1g3tr0bPf8Eu/zvcwY73j2Y1aaej
         zZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755363386; x=1755968186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbRjZf6ZRf2jst0Yfan9jOOyyn6yhDJByZN4z1KAmss=;
        b=CAnHCPFJrI+mD3GY0cD9sHPtzVjpazgh9xKdN11/QVvwWgepmE2G1pvuZQwyNPVDTC
         pBhuP43pmSrHjJ33R+7f/J5lrdh3XXHWnw2sNMhr/KgcGubgtrmmBCeY3Sqa9VDRnjXp
         7PIJdNJ+bZ+URCQSZCMyy0n8Eedt/UmO6W2/Qje8P27F0tBIlikY+0Kh+b3v05Pfn3N/
         7K7SbT46YeLQY6lVAl3JER6rS8mntyDeEjic5IZ+5VgkJ3TcXX8L6m3SaIwsspO4Wm4G
         iiilSgWGgNflWhodhm23aTXLgS4t6rzzitxpcJME69zCEgMSPfchgUYQTsDLq8CNp2TP
         DKVw==
X-Forwarded-Encrypted: i=1; AJvYcCUOMlfI83O3bPsMj6LRHo/nZoPDzEpp/jeb6zJkxRXb0t3ma9iUPV0Z7Wlopg3IN1ND9w14HFjEi+32oKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOl5CrtoR28480GiTT9XeP2T6aCop6KWsziEpUkQl4Yj4RWqfW
	d7skc9Amx+/cWnoya+ZbgtvOmh7JnfBnxA0OYJ8Xi6zFrXd5Xbg2ShfuZ+sHIpBjteo=
X-Gm-Gg: ASbGncvaqWUHeEg1x1m4Lv5v1396NueGvbTb0oUno4YXFPQbcfs/ozpoWB+nMlWtcdm
	t+oBj38zrgbo3wGPIDiY55Rle8809Enw9GbadGv5uietWnp1O7EMHmepEVPe2qJaWr51Pd80hvR
	STjwmCLhVsyy+3dL5KfoS+D1qoPLsErevyrV3GRo1rriCMd15Nt8ydObgm7dBkMRnMERZ8O4GQW
	Lb8RAI3Gg92M9EAHIFjZnT3YpjWghgW5pIQcImQdXAwYGRsT05Fr67IkUk7WrsnwKg21Hz8Dynw
	b9qdh0hvjE2e+GkizOpG/6ewfkwaQi+QieCKj+qeAH0w60qwhfPqsqkG84wg+Z6Mrh7sHbyTuXd
	E677mXpFnw3XsmrzXU0aZ+qSRo/2LwlaZX5ySdAJgNKLOR1Bu+9RgPRy3huv60A21UO4MMZ/E
X-Google-Smtp-Source: AGHT+IE+uLxK9MUTBgNY5LCQoebQIqITz8zvrHvCJ8AkNytTsjr9Sa0XKikZwV3Jg9G284HPN76+vA==
X-Received: by 2002:a05:6808:50d8:b0:435:f353:a648 with SMTP id 5614622812f47-435f353acb8mr1895881b6e.2.1755363386222;
        Sat, 16 Aug 2025 09:56:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203bd13sm932593a34.24.2025.08.16.09.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 09:56:25 -0700 (PDT)
Message-ID: <f089d2fe-562f-46bf-aef2-f19302d3196e@baylibre.com>
Date: Sat, 16 Aug 2025 11:56:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: imu: use min() to improve code
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250816120510.355835-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250816120510.355835-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/25 7:05 AM, Qianfeng Rong wrote:
> Use min() to reduce code in inv_icm42600_buffer_update_fifo_period()
> and inv_icm42600_buffer_update_watermark(), and improve readability.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


