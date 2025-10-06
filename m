Return-Path: <linux-kernel+bounces-842976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3613CBBE1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D97BC4EEAA7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D2285C8C;
	Mon,  6 Oct 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="27ZSLKjA"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5FD285045
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755641; cv=none; b=ghbZJ/KguRM+3LCL9JfHHvcx0QYvLSL3usk0CCjo4ayNuGCQqD5Qp6Plf7VtP8EuprBlJCa3Jn7/2Ft26QxLVFktkO9niQ7MIqedEB7JDW4srOejs96Yn1UZ6RDvNtEhBR3Mo9GdU7U+yJG20pXp24anAKL1QL8eLUrYv2wwW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755641; c=relaxed/simple;
	bh=7Jqk+0Rw48ZsZIR+qXKKV2mT1aS0h7swJqBj47Ge5oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUseDtkEmhjCk2EobCwtsRLPeVCepNwu/BfkZGcamiGsb9hV50jTBnOAlR5dchdx01onLnIlYo4LdxKayu4XecMQ635zWORbTXwKfPjb9gntwji/NGH284+OdPfIw3bfQ7x9pYF3fenahTxgvw/Fef1MgNA4VoRi3e42l2u2EBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=27ZSLKjA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e52279279so32114515e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755638; x=1760360438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ra6UJLsRCiTY4w5Dlw98xmE+EwKNUja03T9QbZDu+Z0=;
        b=27ZSLKjABouIedOlIgPvxXPFf5g331lFoew8SRjeOhfFkbZ8fDVAgXBzUPYsnEqlkJ
         BBwaCSbNHctnsZ6DdCV2D/Xn+lVPSaSH6tFh5VAGwXWq0XR2yJK8g/KuF8Uay10OXT8u
         kBgP8j6h0+V69DFQZ/ost69Ie3O+p33cLItKVCpAM/Q7wYMC4EhWODvvCGhcNLG7hlej
         8wY66uy/btdIjW9X7jrEeNscL2jJM4rtLEVcwHp1r/jlhV1+xfgXfoyoAwgyf+mlwt17
         ioap7uwb6hXTem7Hrn199FeGzf9e8X8NPfsf/+ePFzZboxwdgg/CehEPa01CNXIwxzcC
         Bt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755638; x=1760360438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ra6UJLsRCiTY4w5Dlw98xmE+EwKNUja03T9QbZDu+Z0=;
        b=qdEQnCelKDT7Sprxwpuxs507BNGFd3kWIKWGeC/5AGmFND/phqaY97GAElcXb6I+5w
         0TqwVA12foUINgFcFo6J/bjMyQaVh+Kitk4e0Cb7ByNJIWSnOKEKB7E60OhB0NAuzIeX
         QktlD+sRjhGImL/LtSfUZJyd9Xze/sW8kD1/B4j4Lue1SYJWZnwWZyE39c3J/QO93JmE
         gw5Fq0OuhU3l0LeBpRPt7I8tl7NfuMdcbdnUpFbRNSWAo9uc8uCD2r/2beCH2XoRtWgC
         49HZb+c3soeIzxL0SfiU6/qDWSdLwfzDx7NDvsIEsPdr3Rq/5xzrOYVnNLxab58+TM63
         yLyw==
X-Forwarded-Encrypted: i=1; AJvYcCUzY857LyFyOrwmeSK3A1AL5tGo3HTIisFf8jjLJEvfZMePYX7ZdjDPNWzY9yLHPkkmr+qxezuDumMTDbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3hU5w3zQpRodpAQop3rVsXnPgMtQ24WPBz5sbeuTAnUJLOhT
	SKrKsKKyjNdolnazDTBPBXXLgOMtJ+Vl/m4FkWPgkpvVjAC8MF5VBgbyzC+FljaptyA=
X-Gm-Gg: ASbGncvKUhivMyDd78qZDuLAu2GAJleOTnD4kqw9GvTE15NyIpWgwZjjF9kiCnY4NxL
	71WIuHmBz/RM6jJaFy95+5D02c0A7Bp60lpUwo+3LxX8sk3YwmEPn8SaMDCKogPcP6pmZjaU0VS
	VpVXUKU2i+rR2RuZlJCWYjdJjVDK5Ezu3LNiSmTp2dpZluJEIZVMB0BF35JGV8MZAroZim7spAp
	2kidW2VUb9o0VGdQ1CX2dCA02D1hQXk9DCec+0BfXSzqkGtzLNzEpoJLzLNJIQ/TJNHlqgwcaCK
	tPYULf96dll5/6TBjOaWFbishfwFA0lytoDCoqjck0MT0OOmMpJTzbHZc8GkqShsMPFn5xP7vFh
	cvPmitw5wA5pyUcDXwGyPzlMNXG2/6aMAVYLrulq4ig==
X-Google-Smtp-Source: AGHT+IFgLzIgY3pkjgFzcgT7VNRTa7prqsen/gecYHE31rP7DqfrVJpmATXrYOO7DsFU0yHLX2VQ4A==
X-Received: by 2002:a05:600c:628b:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-46e71147470mr88630675e9.30.1759755637657;
        Mon, 06 Oct 2025 06:00:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:17 +0200
Subject: [PATCH 2/9] software node: increase the reference of the swnode by
 its fwnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-2-6d3325b9af42@linaro.org>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
In-Reply-To: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=853;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=sIF2HhSB+nj6SiXIxMNel4X3wr1KbNilnoWbpiOKTXI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471vLK1Kim9deZ74HcxK7aZgD3whmeIXPRFm3
 KMWG/Qweg6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9bwAKCRARpy6gFHHX
 crY8D/4xCm2koNyAO0n6ZToGqSga0HZbAspeEHKSlOdzR+hLK7wgy3tiCpeIkn1vsGNDzZvfjG/
 Iu/rHEbo4OFbPnDz9bPMBqP+xe6s+9GR9NZiP03Z7e/PMub6BMnZraYcjpy4QN6KvjcSncdVulD
 a/tMUeKQ3gRwJEZV18YR/+o5zeZijpDqTJioG8hLg0Mp01pWBgogC/dz0AtWMFmjNjCdXX0IzXG
 nku+rFzKnJryquTRkJyTNL4c2hT8wZvR0D4uuuarJfsZMkNIyGMSRmeOrQwycBpujl71Xto8rP/
 YY6CojcJQ5/cZaU1SiU2j4OweLodeL5+WHPJXkLBMgvU4+n+CuTLhfw0kfFFWNst319LloP0iV8
 2NOAKcrmZ6A0ThSN6OfaP2gmSAMuU9ujuKazl0ppnYckr9F5ZA+IpYHpdbz9DB8Inic+U5BZigY
 aoG3FPKSxEE1AXEHdZzLeVLiBv1/7TkR+2U/8QqxaSFdX+bZzIAl4J1Hj5hwsgykZ64ojbwnV4C
 gJaslMY+7nrGc9VZTBj6Z0JPR7VVb4652BBj3ykkDjFKkpJiDb/+cLtOe2K7A0IexmhJxy5lADQ
 GuPu4B4vaA+LXGKEw74D+/yYgfPc+VVFApB1Xl7dPlsUJCLoUbjkfDx0copwxMQC7hgqU0mM7tc
 Gmrzs0jEt7n8Kdg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference other kinds of firmware nodes,
the node in args will no longer necessarily be a software node so bump
its reference count using its fwnode interface.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index cc48cff54d9c3d4d257095b6cb4a7869bf657373..a60ba4327db8b967034b296b73c948aa5746a094 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -554,7 +554,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (!args)
 		return 0;
 
-	args->fwnode = software_node_get(refnode);
+	args->fwnode = fwnode_handle_get(refnode);
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)

-- 
2.48.1


