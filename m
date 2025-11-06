Return-Path: <linux-kernel+bounces-889082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC6CC3CA54
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAFD189CFC9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E2340A6D;
	Thu,  6 Nov 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzBP2mjo"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0430F955
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448256; cv=none; b=ZMKpBgYVOQh4KeyeusjHwoLuHgsdbBHSmdJC64nKqSrUcmUPNK2u6JT6dUrz5eBLoDShTsWYEE1RVcxMOvxkwOSd+/bKTRByXcYYmF+7tqXetSLKvEJJqh3fD5ifByttLtJOpzpO180FjOfRsgF/C/VMtLCmjaYOMeC79xHlIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448256; c=relaxed/simple;
	bh=hBDgCtgFgAJQ+dFgpCAhZa6Nwb6Otzu4vBYt89g6zhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bdc6wJJfelWatPYGnMvaQXBExaifgKPCtcdIYxKTxBvJbztnAyUfbDJ0CXkizIiy40tHk4Nkei9jJdUzY249T8f2Ql4ycr3G2H/zznZkqkCLoyRO0Li7OLTJALBMalvEf6rkqkduQ2BZNRxXa5kyoYhqdpRv17SVyXvf8QEwxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzBP2mjo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4298b49f103so506583f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448253; x=1763053053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43X08dmID9sHRRXmcYSgNQdluMQg9kQE7si7yBN+Lnw=;
        b=YzBP2mjoYJlN+ibY9A1ZN+YiX938uhrqDxm4UkvB4ICKAcjE0UBtG71OBZwOO0fm81
         /m9lJ6D+E71KXVUR0xltwsxwPu4mJyQmbUEYf9AEsKjBXe6UgyFqo+Jg0LIBoAV+7pCg
         VuRyfhqYcyeka3I8J3jzpyh6BfqfZHqbZ9VuoSZMpUrmUxgnYPkkCLk0MStmp68sU/ml
         BGvjaMSSOYzBvKauKDzAJW7h6kFgFte2SPVB5Fo3boQS9lnvLvJofxRG3eZFOkgnhY0q
         qD/6BzbXunpquYgnCyNSy2H3Es5ImYHkezlEDHdhwxTuACaS0QLwPLKuKHVt888rYW3X
         CItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448253; x=1763053053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43X08dmID9sHRRXmcYSgNQdluMQg9kQE7si7yBN+Lnw=;
        b=Fhu1Hd5MtBp1JKBLiwrY2oDeaHcrxF2xVYS3S75+RlGcKYM1EtGGHak6O0m6+HKjdv
         PnIk3/Jce7VU09jx0+/s05nmzCFs7sDWfze93EnOuxoqcMdaiuaPH+BnMcvb3fqnadsG
         kyogBgmE8py6xE7LhpDWvrjIJQnKIOsetV2wMpypB4E/OKRCu5JL8OxHE91fOvPjQ7nK
         nmhYstTa/kr7/eUJbw9ETVbDrPy151DGtfnfiQfS0//zkqgb4KCQA6GZecZhIfUZ88A/
         rcMKLvRjeM/BLYXWRxjzfVm4qNK93yhn0kxFeZGgU4R7eVmR3JPOcyDQVDNOiV7yvAPt
         d3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJcM9re5CgFZLiKIJyoFWw/TfXWwauHx5Un08Rbzg2V+h4aoG04nxUbfhDD4i1dK8+2g1Y17CYKWVraVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIqVwFW44u3M9qG4X9KqTHp2ati8dCBmxAnHLYNsZsx0QzXA4T
	WTNxKlBON/FWb6PliEBlJ1ZgN0fXa/0XawhBbHQKhAtAlptmzUIvTDA+
X-Gm-Gg: ASbGncsSVHVtiG5EY3FfGosNy5J/CLTsIOq71xAeaFR1jtIhqSfgxGKUX/NdIvy4/Yh
	Dl3X1sEXoTRdAPgl8rwTkYcY6ZVqFQZlDMLuauD5UVfgDrpU3ZM4C3rWm0XiFLm6EKIiXFUmO84
	0xmMSm3DBpwNdWeec1ECq4z2yRITv0bsMN/0GbuNo7J53Ht+MCOH/XnvKt4777mOPkv4TBP8rPG
	31+VAnqtHs0PsRpJ1Jvuh2NnBdW2x/UNLAOVX7z9TCGESTZQs+kxgorhtMOskH8gqIbqkkSbhjU
	3QHKj3A5P88zq7DGR6NwDgFJ+1cKgLR8cNnpiATvhjWSa42RA5WWH6smFIRvcnDX4L3l9QYqPoq
	dViAXcwfDcIcWA6/11EKV+smr4TKqfx9P9pQxLt2ipm3n2JWOKIfKrcHGIUjNo30vuQWdYO7MW8
	M/emsbYXfaKFpVRQCl9i0=
X-Google-Smtp-Source: AGHT+IFS3q2CQsG6hf1nqt/xuzgOKYXHnA+wB0Q9tXjzEjx/qrI7jVB+0ubmL/kqbQM56u/55k8zCg==
X-Received: by 2002:a05:6000:4013:b0:429:d3c9:b889 with SMTP id ffacd0b85a97d-429e32c81d5mr6488088f8f.1.1762448252844;
        Thu, 06 Nov 2025 08:57:32 -0800 (PST)
Received: from cachyos-x8664.ujaen.es ([150.214.100.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cbefsm80306f8f.27.2025.11.06.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:57:32 -0800 (PST)
From: Marcos Vega <marcosmola2@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcos Vega <marcosmola2@gmail.com>
Subject: [PATCH v2] [PATCH v2] platform/x86: hp-wmi: Fixed Omen MAX 16-ah0xx board name
Date: Thu,  6 Nov 2025 17:56:57 +0100
Message-ID: <20251106165657.23241-1-marcosmola2@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <81699228-710c-144c-0909-1fe5be0604ca@linux.intel.com>
References: <81699228-710c-144c-0909-1fe5be0604ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

You are totally right, after more thorough testing, I realised I had made a mistake,
board 8D41 must only go on victus_s_thermal_profile_boards.

I send the correct commit in hopes to fix this.
This is my first time contributing to the kernel, ¡thank you for your patience!

Signed-off-by: Marcos Vega <marcosmola2@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 8b3533d6ba09..7a3cad80f0b5 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -92,9 +92,10 @@ static const char * const victus_thermal_profile_boards[] = {
 	"8A25"
 };
 
-/* DMI Board names of Victus 16-r1000 and Victus 16-s1000 laptops */
+/* DMI Board names of Victus 16-r1000 and Victus 16-s1000 laptops, as well
+   as some Omen boards using this profile */
 static const char * const victus_s_thermal_profile_boards[] = {
-	"8C99", "8C9C"
+	"8C99", "8C9C", "8D41"
 };
 
 enum hp_wmi_radio {
-- 
2.51.2


