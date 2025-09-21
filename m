Return-Path: <linux-kernel+bounces-826386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E23B8E5F1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0B716F100
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1D829293D;
	Sun, 21 Sep 2025 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIZCIlLR"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714B2765E8
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488792; cv=none; b=WYXCxnelRbq/KxYLuq6wcKmdjYgKZqGgX4bz4UTLWYaU8C0yU+cSezMX6Dv3jYbfKCKfKMYyOwqQxywBpT6IotLQ2Wwd4oem0FHClQujjhPYO+Q4NdEwmiRH0KO+wVEV8FziH44b5IObRl8/uUqoGCX/0qoo2d4m1WIoMTG+ECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488792; c=relaxed/simple;
	bh=1dUSsg5D1sQ/n6aucsx7OOyNbAsbZlL33M7HbOlr4DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QsFyRNLo3wnVEDrFKuwzXsuyVED0SAXZDAYI8PgH2wh5LF255iqsQuhe/7eN53UWq/3OUNg7qo+b/kCp00myP6owa8kZ3n3Bf8+YUaNz+KTwuVLBHzjdG0UzVxbrQkwJEjuqNXy5Nxyl/rjQzGIY1hUc4IsphlLNSXQPwONPlWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIZCIlLR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so3321245a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758488791; x=1759093591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1dUSsg5D1sQ/n6aucsx7OOyNbAsbZlL33M7HbOlr4DY=;
        b=KIZCIlLRK/J5DE7wfc2qMimNHM1lE/jd51LnR9YAFO3ZqetpwjOpYgJqw+VTSSiFqE
         +ZAzHrazliTAWNMpPGgTZGVj7iozbP7rwq6eMKAccmkkxVoc0QovmyVPxI0RUfNSrW8U
         3iJU4IBrD+AszpIiG076Or7uCOkQ5Y9CPEBKFGUpvjR1WBqUN4f2RKPN5/nKxhJtDiqw
         qpbnw7UTzFPTWm9KQg8j4T/3LaNNdPwes9QUSV5ZfH7RHHOQ3Te25+vXxS1EP4tJ6LgR
         fjVdduEdLs/VH0O6L2ku2aRSGIEZIYJbR2uSJEPpwcK8kfmv4Imt/ZEPPvN5z4VcxAV2
         lH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488791; x=1759093591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dUSsg5D1sQ/n6aucsx7OOyNbAsbZlL33M7HbOlr4DY=;
        b=o7gT9egLwBedpZh9zot+A0iCQoTREwpJRcXFBtvd5ZNbLUGUcG4iE6nnc9HWorlk1Y
         8rwcXbJACDqMtZzrs8zpXF9U/AIYuQBmsORYTMhgpshKqmutKok8wn4sJhIqmjbsNHQn
         8xcShq14hSAj42nwhQZgil7T1N/sZq4OmfDIO22l8Upz4IjoS5DcwuHGroQoAByKHYo8
         62yCmDO/OaAyvIyQ0eEAg5pSEZi5KQse38HYh2nbHGRwXtUBApCSmHR8erCeVuxnDW7A
         EPNd8D9O8nxBVpLk5h6+t9zAMZYPLblHXcCwp8P9Rf0+y4lIIpPPxJkkwM/dpjRQzV2+
         bsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaAcD+YbEtHvoyWxMJPLPUHJiCwGoT+5rUccEZSh2ihmtEA0frWFJ0k1jHsx4aHrOfNzOXYIynea8oBqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6VEiUYkdwELIPdq3nrhN8spAxFqNMqqleccd+Wu5ppEB4LY9
	exKVFFZUitnklcti5W+XlCzFQmhVWhgzLK4jxfYJin9T0JviUrOgkwO0
X-Gm-Gg: ASbGncsHF44emihshP55MFBV+okkHLvxdvBUsgIE4zqxGIHqq64LqDXG0Cup5+znQL5
	+Mz4ufp/5gLV7F12k/WZlhk21FGc/Uy30tyTHzVXr4agMcWMDKsRUq5TMryQbd2xmr5ZsMBaJCB
	JFT4woDHsrPKlVOTkAtF8roeI6CY+32DMAY3S7JoXDopHMSwodVFJnqE0olt+Il5rnl8+Khxkjv
	2SbvlH6oMBgfiQ4zrXTMNg74fVVhgI3fch9owaisylqpVVNpPRB9MEjrMmXD+74GuYFRgHIfl49
	Yv1ZU4vtQqx6ILzs0GatYtpV61t1L8lwmm/gB5GTBrmy0yhGPmrHlA8VTXvMkyeeZ40eXTtxZnA
	UO4Dfeo8niuhtW/4kAsF9oQb+ooSDArsXRhLfuHULxGL9aoj2Kk07nhiNtaK8HA1sItHWc2yCPd
	jn
X-Google-Smtp-Source: AGHT+IHZQgmOYDYkwaNRw5Ez0iNg/VNiStfoYUByPz6lPez924U30hCMS1gj1w6xAjrT5JiXzjQYnQ==
X-Received: by 2002:a17:902:e810:b0:272:dee1:c133 with SMTP id d9443c01a7336-272dee1c1afmr68492865ad.22.1758488790660;
        Sun, 21 Sep 2025 14:06:30 -0700 (PDT)
Received: from [192.168.68.63] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698019665esm112448845ad.62.2025.09.21.14.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 14:06:30 -0700 (PDT)
Message-ID: <84c979f8-2bd9-4d4e-8437-0b4d3d119586@gmail.com>
Date: Sun, 21 Sep 2025 14:06:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: rk3399-pinephone-pro: Fix voltage
 threshold for volume down key
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
 <20250921-ppp_light_accel_mag_vol-down-v2-5-e6bcc6ca74ae@gmail.com>
 <addgrqhxanzrjdhb7y7y2qrqu4odpoclbwlswuua4yqinrzh2l@wcdtuquzuqvr>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <addgrqhxanzrjdhb7y7y2qrqu4odpoclbwlswuua4yqinrzh2l@wcdtuquzuqvr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

 > So the correct fix here is to change both button thresholds to:
 >
 >   Volume Down
 >
 >     press-threshold-microvolt = <300000>;
 >
 >   Volume Up
 >
 >     press-threshold-microvolt = <2000>;

Thanks, addressed in v3!

Rudraksha


