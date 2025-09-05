Return-Path: <linux-kernel+bounces-803869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C5B4669B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0203178619
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A64296159;
	Fri,  5 Sep 2025 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="22LhNmKX"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F42877C5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110938; cv=none; b=IPrQGp2AvlARPP1+myc1hY0JQy2uHki5EbYMg0V60m7Oh3d9lXr4uWOLmROyizbV2MQiB86BhaTvKNqon0CRYr4SiujdKwpskH5+k7vHdyR8lgdQ7NYzShxCLzRKfa5A9ggxbNsxgHeHghZ0zSl1vFWgOWChcZ5ck+ZYxwHTMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110938; c=relaxed/simple;
	bh=q4x9gU5XisbXR7MWXrQ3Kn8NypkdsrYkmqq2J33ZMO8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rFQFRx05pl8loK3ItNyTO5VRjMfMV/snpInsU31tx/Bcz4LvLc1r5E51GGCRLfmeDV6ARs2rrPlkZdrh/NnQA0def69Hmww0eLWsgkZ6PSr5QDhfPGAjDikfgP3LK/2H8IMsiQh4LAwbTm3zw4TIVfeqltidTAWLEFGAWmtHG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=22LhNmKX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1733971a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757110936; x=1757715736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBGiXTRWAGjYBGB86C8dW2qAaRD4gUKSDgviMv2oSII=;
        b=22LhNmKX/yoK/r+kRJ3+XwRQrcd5ngG/3A4ijAVvy6Ytf5X452sqUoQBj87pC5QogU
         S0VhUGVRGK3gD/cJ2hPfeU+Nn7599qfvrviinWAf+RnFAXJd3W1L3wyDgkgPizmh8DNO
         5SLtRrT0JxW1Hxyw1aJIXssL68jaZvfrMgI4Z8WDq7UAnjxm1JiLlbx6X72g9BrOGA4a
         zn/IPqlV63JoxohQdLIvpzp54Tvju/o88tdAMulSInkL5f6y9HJTQYZcPkzHsi+lpcyM
         b9hK9V4Fxm/iByn5dPMiyPEBtybrGVTuqpmeUvI+mpyfeaJOZvQJFsKQl7+q8soEYFul
         QBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757110936; x=1757715736;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBGiXTRWAGjYBGB86C8dW2qAaRD4gUKSDgviMv2oSII=;
        b=NTEPUojVmdxggP07298wnt66uuq/Kv626bnafFxPikmIqsCFMBcUtAwOtot5V1Y213
         V6ALyho+8TibHIDkZL++Z92N65T1iMGh/4n4NjEXWEHhQR/sfkD6lTfr+F0bMXsMEJBQ
         x93vf2Ic3qBbW+6YGh7ru0MSBVTmLgI2I5Y+5q4Bb7OWAzlRgOc5/iux+Oc1wFfLU9yP
         3YdIqzQJuAtdT/txdps2ozSgkL1E5Kg3msty8icf9qu6MUPFC2MI1uGpxXJYo/2cG0oI
         mE7hvCEbrWBfrxOR2TIubL1Rxot52zQ/VaeCZVL6udvwM6RenQkufe6HZSobRG7LEW6Q
         zAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHjOd6mHnazahHQcduJS4goxBKnSv8dac2RuZiVJ+SL/fya4XNPwdZ3Bfv7ix3L2QffCfGW/Y/EWVqYXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AyViXw3x/mH1AEqUk5BaZppmo7CIWRaY7sRH+O5VMBcTgRfw
	W9cdHXWSZW+zBJN0dDF9ALUplgKUPv5NLEgZ4TGjHyHMV+fU4MfvsFcwsv40U9S+wKI=
X-Gm-Gg: ASbGncsw6cZiAVbvqGfJRFQlf3jbGAS0tgs/RPsxgd0F406bnhN0D2blDWm72pIBlDA
	GcDcVHyv/i4F5xNj1/RGNTVlzp5TKaXSBgXgPbQLVIGeCjecdFcldc+dGhlTDtpfAFPxeIW+V+J
	/r25x7YOZSQqhw3XOXvn0SsGgswbHHvR6q4iZG5+YkT3A6GNx3tMenQWrf/EbtqizGXv+07Qabp
	ZwKdT7j/kCvmAcHCenUWVqOmkxyuK6PUOBDIkPhpec1gLn85AA28kekygBDy1nbSOpiwiCtVpzW
	HCjRpGYmCmqhATWRsfkHWJ4XbSJt/kIimmjPGypQPnYBPUHjb6yagBiP9Rq/szWWS57pB6MdqNI
	ZfE8AaE9fKZM7z7z9XuwuJXbKtb5bF1U=
X-Google-Smtp-Source: AGHT+IFE05TJtfqGSyHWnJAp1HNp9W7FNnnwA+jbOsFE8Rf8W520wf12+dz2Te7dKhBHic9rRWcDWA==
X-Received: by 2002:a17:902:dacf:b0:250:a6ae:f4cd with SMTP id d9443c01a7336-25174c1a971mr2867455ad.44.1757110936014;
        Fri, 05 Sep 2025 15:22:16 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b14e1b097sm110499695ad.21.2025.09.05.15.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:22:15 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: tony@atomide.com, Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shuah@kernel.org
In-Reply-To: <20250822222530.113520-1-jihed.chaibi.dev@gmail.com>
References: <20250822222530.113520-1-jihed.chaibi.dev@gmail.com>
Subject: Re: [PATCH] ARM: dts: ti: omap: am335x-baltos: Fix
 ti,en-ck32k-xtal property in DTS to use correct boolean syntax
Message-Id: <175711093513.666031.18135228669167413302.b4-ty@baylibre.com>
Date: Fri, 05 Sep 2025 15:22:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Sat, 23 Aug 2025 00:25:30 +0200, Jihed Chaibi wrote:
> The ti,en-ck32k-xtal property, defined as a boolean in the Device Tree
> schema, was incorrectly assigned a value (<1>) in the DTS file, causing
> a validation error: "size (4) error for type flag". The driver uses
> of_property_read_bool(), expecting a boolean. Remove the value to fix
> the dtbs_check error.
> 
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: ti: omap: am335x-baltos: Fix ti,en-ck32k-xtal property in DTS to use correct boolean syntax
      commit: 9658a92fad1889ff92fa4bd668cd61052687245a

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


