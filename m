Return-Path: <linux-kernel+bounces-859631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC8BEE27D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C7C3E2789
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F030F29D281;
	Sun, 19 Oct 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM5Bfmmd"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5112E041A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760867507; cv=none; b=FhM2KTzK9aatnTaCwUMJwtF4B4SXxO+L3xIbr/luD2Hj9jT953rWh5bzXngVK9tzdWzQd+IJLCeYuz+DJvIQk0wwqjJw3Jl2drG34o9+Ay22DImOds9GA96dItXwM0xMqai5BIBI30+wcDN335rLZTma6Ofg6bX856f17eQ2fO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760867507; c=relaxed/simple;
	bh=StQ6hiSS/ddwlsO576uA8gheOyDnzmZgNCzeCn8v2yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUEPd+zgDLb6POMn/ff+1D3FYAWGZddy5A7JDbJ96GAOaws2TGmOQxAQboQAiL7A3DCY+xncF4chMXJ28TrM8Omk9QexnP0nA+aKXZR3/VS5bTZMELTnUTQEXttkECPENlFgWdBHUXUTr/KzFPuitGOBBde+uQcAfdSDALxRm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM5Bfmmd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57a960fe78fso4488310e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760867504; x=1761472304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+DYglWBDI71zz/BrQNEMs/n8cMj7C4w9i31aDwg9uA=;
        b=YM5BfmmdTm2crHm8SpTJyauU9zRwRagmBQqLeWCceklsUcmzPE0Vr8Vc73lg9AFwNo
         pVwccn2jPjXAcWv+7hiZEbCsQ1yjk8WPGUROnB+wtjp4QSCDAwRR9x+Iw7gS6T+bpFC8
         9iFmRizSQFiA1ydoffF7E72BmmTEhlV8XeBGI6d6A35wSYGWIYuILCOe1/x8nH7cr8io
         UggGwrzmlCftW1nYXTuUp8z9opLhGwh6gJLVjYj7uAqHc7eCSFzX3GVE94+g4uyCUFrG
         XjsUOYh41RyNAVsulpIdALjzALEGGk7/fs9fm0ZPMGsR2G7apU3nzMw2bN+jf7zEew87
         wQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760867504; x=1761472304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+DYglWBDI71zz/BrQNEMs/n8cMj7C4w9i31aDwg9uA=;
        b=WtJ0YuO38gKjzv2gGsXYiNMjjmiwSKBw03MDXElmlN4KrXZTlxC4eHK9fMkH9LoZ+b
         nhCexCc+XIE8f5+6tPg46lHZLn9EYhMJcQxGIBPPvu6whmS47UvP87H3vIyCc9l1xv6D
         Mo3k0/Iu5NvjD9q3jkyKY27Ryce2Y4uyzMqD/OxliGKptg6W43USZbCo3l2kmfXd5O0K
         6TWlPA3iePjX+oo2lxwTDVn5qVlI5q95MWNrcTkD9nk4Vkkzezep7hmUj2sQJJsHpvCo
         kSSQSUcIb7xfuQ0/Wg4KwEywMIQC1743oXKCJ1VYdZgyEvTkvvOh9KIBB4jWSoLYg1Aw
         o53w==
X-Forwarded-Encrypted: i=1; AJvYcCW+1D5a6+kjgvm2OOMWG1wmc7MQLPC2e+17Ijtq5SnxB1u/H4+lp0nXHLur45iGonuQH9FoumpYCpIcwJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PZXMWzKROzk2H9HHh61oJbxM5OyGCl01kNi/AkdYNMND6cvy
	aV15+Uhn7VK7WUD7QIyNJDUtF1srrxqL3gsw9JMCAXQq5t/DuO6pYLBO
X-Gm-Gg: ASbGnctL2gJMzQJWWqNacZ5vxTfEK7SvV/PXvCIwdE76qGFhM4CXj3+psv0QncB2lCE
	oCoLr47qaEX02aV2k8zxMWeW97sPdrTZEVLGw/spmSXZKoCIuwP63HAh2biiUqXZ/xLDdu/DRZG
	8cIahfeG2iheH6C4BskjP+v+5GkAgKMNddZVPqw8wFBjA7qx96qUgQRLWe+I8oZpWszYM9LoD81
	kq4A8WXey7G56ieTkdLSN6thiMrQSFbY3IWnoAYRBU+nDkhAiQgm71Xq5t+B2jPiIdbyNcXhVkw
	29Zay/Bb6EkraaN/bkh9R1eN65buaMmuWWo56Pv0DVwBRXc9uopBxZ8SsFxPxd3grWdgyzMdxSi
	iXKo3bLtKB264QXUWxt15ZjvfaZonkIFnOJ4SEvYoYjrfdbmtKPzs9fRH1XXfJhFruHMX+x+8et
	p3
X-Google-Smtp-Source: AGHT+IEk7oK3CvYkCqvLOZMVwW2h+hwBO81K6lyYByY9eQ+fsQlUxRuRCe5/anMAeziBgkE5R5Avug==
X-Received: by 2002:a05:6512:39c2:b0:591:d120:1094 with SMTP id 2adb3069b0e04-591d8577799mr2641550e87.33.1760867503501;
        Sun, 19 Oct 2025 02:51:43 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaf49bsm1425739e87.28.2025.10.19.02.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 02:51:42 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: gregkh@linuxfoundation.org
Cc: a.shimko.dev@gmail.com,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	p.zabel@pengutronix.de,
	stable@vger.kernel.org
Subject: [PATCH v3] serial: 8250_dw: handle reset control deassert error
Date: Sun, 19 Oct 2025 12:51:31 +0300
Message-ID: <20251019095131.252848-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025101902-puritan-thrift-b2d4@gregkh>
References: <2025101902-puritan-thrift-b2d4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Fixes: acbdad8dd1ab ("serial: 8250_dw: simplify optional reset handling")
Cc: stable@vger.kernel.org
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hi,

Done.

Thank you!

Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251009081309.2021600-1-a.shimko.dev@gmail.com/T/#u
  v2:
    * https://lore.kernel.org/all/20251019085325.250657-1-a.shimko.dev@gmail.com/
  v3:
  	* Add Cc: stable@vger.kernel.org

 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..710ae4d40aec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -635,7 +635,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
-- 
2.43.0


