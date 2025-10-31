Return-Path: <linux-kernel+bounces-880237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6522C25336
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B39B4F9B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874134B430;
	Fri, 31 Oct 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKUuAA8u"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAEB34B411
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915908; cv=none; b=a+lNPoWlvZAXKrG8krAGLCfzrfW0Mga1lpFgIEbj0yLOh0QO27RBpBKp8VCAR5XOxjCLsiinlUXAaHL6sKGm6qxBzn0FrbjF3aq2hZpxEhjYk51hiJdAbIRh7mRPk1n7NA1k3H2gadvVbl0TXn0XuanRwq2iGDfLe4sYu1O/UJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915908; c=relaxed/simple;
	bh=ohLTL0SvpZNw1YyqDgj7e+a1xa9YzqNdtbvCbNOK1Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h9WU1G9DfbuKixeJs6FIPlcuA9EjAvXG27ujzbJ2y/No6QBV+qkbQTuY1MiJ0i2XV4t8leII8xmzp/j21bzVcrfcT8xivBG2AeQMo2+DwTMkQI7xJ/uF6C0Htqhr3CYaoS5qHWNoqhVRQuG1cJX97HHzifNk0XtsU4nHZyh9Osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WKUuAA8u; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso29330465e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915905; x=1762520705; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+w8jqf2lCxSEA+gKuomLF8ByPnOiEIRxtEHIBbMby5M=;
        b=WKUuAA8udu4w586zlyk6R83XVRBVK+QbQAx10NwNt6RXYxYb/rEHdS6kcQLMkhG1pv
         9ST5l8+qPAVXWBA9LM/L6FzfRAi59AwCAdYofww4RJwxavGQanzqPztneObNQdaDHaXV
         HpXv1x7zBi8oiF+74ID3GU1cySw0/PllMzxNhhy7QP1bvwX/qyrziX5gJaDdZrRQ8wdo
         4adrxPwtiCqtcwCAZuOQiKPr3wdDcdciJ1m3cqASQA18cSTGmHgPLr0ON7tC3MXQ7bzC
         ygiH3gQgRC6yVWDCbdAMGfB/YKmj90Gn76+AtJ7qUCBmlo2qDGFyJC+1f0s2ccN/q/Xs
         sj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915905; x=1762520705;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+w8jqf2lCxSEA+gKuomLF8ByPnOiEIRxtEHIBbMby5M=;
        b=WsEjjkMGh4gN6tFxoNiFUKGm0twg1raWIx65nXRmcX6sPV9gdXibAlpzAd4dCtelYT
         eRkG8fT0ZUE5i+I4RwiJlpG0Cej7XRgmLueturQPgA1A6HJs1oadkSZ0tjPAnxe6DMf2
         qYyppMuEq2sf0WROeaZ9mhTwP6YIyzYP7Wbl19VgXegY4x2Uni0J0c9Ql9iF9LI+QLZw
         7aIVGRS82tfkNccKVjCeNu5MkieZ/rJOPkrGdC3fXSTaDFjOGOjD+NKtHockDfeu9DKY
         rzc/EAPcB1Qh4r0Zs2cpjkMBNpTPxL79TuNCcGzbBn9+JJ0gOB/mEpI2m/1iCqJkr7bA
         w2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU5qqjbEgdJv7SEwsfwk9ECq2FjByKPg4+/i/7UIOuNLdgFIQCeLRSYqaqO+GOBs00yyKJtr3PGN9DAebg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfO4x2wi8YOqgeoSc4Ijdd4KfnUtYUtIp0uviK8sotjsH+Jlo
	dzgPFzx3vj9kHYgSawOMBXEXoiSLv5qysrUle6Wu6hjxaM7WxyaUwJemiKyDNKFDri4=
X-Gm-Gg: ASbGncvIAtV2m7T24WpH8iTm6TcFEYLRy89jkVuaeckueBOpFzANjhpDsVH6mN+aT/G
	aYwd+4UYybFdwD9RmCPbUEVbKHwS0l2IDWWfQrGFFkJIJnj7rDxEX2Co9MYgbc/05Yb6/2Honyf
	CVqAfaVIkUWIuaGlVi92m9CBkd4nVjo9fro9hjc0sfOIKuAE+GUK9RxajoVFl0PPscAITgK0LuB
	a8BZ5eSSYaU6pTidNqdhzjp8TzDkxlvkrc+ESEdBL7w938YnAR8f6QzZ42/JcE3h46v9ajTtGen
	T8CP2DgrEpKmEZt+DXvtd3IYGhS9EMKwPdE3GdFsMpYwWU1sQ0h7Wy4+HOlAQlHXo26OJ50etAj
	ckQ/N19e6kbziHwI9SAUGWvMSdoOJUteRgLCYZNT+bVmeGyWTYF7Efo4GYLSF+RGTY+rfnzHziu
	K4jOGMz5i/DgOX/08/
X-Google-Smtp-Source: AGHT+IEJtNSHRo+8kbxShLrSYoJ1sltDyk37yajDo7sugoAhpxuanGQrpoVYtZmOoClzTAqz2jv3ug==
X-Received: by 2002:a05:600c:a44:b0:477:df3:1453 with SMTP id 5b1f17b1804b1-477308cd816mr35529135e9.28.1761915904754;
        Fri, 31 Oct 2025 06:05:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c1406a45sm3485008f8f.47.2025.10.31.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:05:04 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:05:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tristram Ha <tristram.ha@microchip.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: dsa: microchip: Fix a link check in
 ksz9477_pcs_read()
Message-ID: <aQSz_euUg0Ja8ZaH@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The BMSR_LSTATUS define is 0x4 but the "p->phydev.link" variable
is a 1 bit bitfield in a u32.  Since 4 doesn't fit in 0-1 range
it means that ".link" is always set to false.  Add a !! to fix
this.

Fixes: e8c35bfce4c1 ("net: dsa: microchip: Add SGMII port support to KSZ9477 switch")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is from a new static checker warning Harshit and I wrote.  Untested.

 drivers/net/dsa/microchip/ksz9477.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index d747ea1c41a7..cf67d6377719 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -244,7 +244,7 @@ static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
 				p->phydev.link = 0;
 			}
 		} else if (reg == MII_BMSR) {
-			p->phydev.link = (val & BMSR_LSTATUS);
+			p->phydev.link = !!(val & BMSR_LSTATUS);
 		}
 	}
 
-- 
2.51.0


