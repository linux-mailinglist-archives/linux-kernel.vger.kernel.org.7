Return-Path: <linux-kernel+bounces-826683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24889B8F1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CA8166FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388C2517AC;
	Mon, 22 Sep 2025 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVx8cdA0"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF472D592D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522108; cv=none; b=ONr/RjMHpcZ1rH8hkEZcKvQoDXHnWCA80+x6R3GRC3dVyNF9aql/CqIXjp1xFGQkSxsF8s+JyJpei+k+aycui1n2Go/ugm+acTqoCF9XFXu4SGgYP2/FkGrTrdyrWjFus7WyQd0IO2UApfFSk6gHFJcMfhYWC2KSp2gOKxsfScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522108; c=relaxed/simple;
	bh=UBc7AM0gSO9uZhPLncPbz9SMwH2LrhqeMCqUzN/cGpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZGQ42nv08g4JiXlkyRCNBSCEmLahXWfbMaso7X2P4gUIjYBpLRZPhviasfeQEn1xK90Ac8Gc0NsQfHUzPZNnNmCXxPWQ0B2lykLrDeZHTniEeW17RPiHnRBbKmdFr+Ei8mhle4ntyjeLN9Z7s5ZDMDoSmc81B9ncH8dbe4dgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVx8cdA0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-362acd22c78so33419741fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758522105; x=1759126905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tflbFhpYb7LhX1EKPWzM1vNL9oW2j1u/K47rwyVr7HA=;
        b=QVx8cdA0HwrUcN42Q63iNqTCLOXRjyhMpsAtucHoabu8rOdLScRMzVXEYyFSg/KDme
         aBCzG7HnWbm52jF6gKgPMwPctyPicBpKkQexMKISZUqn7WAEUKy/Bx3LYoi0iO72Ivf1
         tvO3hQijRTpvKYO8wSwvUimJUolJO6CoiG6E5T/Y6KuSpnzLD+ADnqkNaVK+rmqatMuG
         10Yf0bh+z1qoOIE+eZ/Sizt3a357t/SFykz2qXYjyRfcJBLmHK51oR4u017bl7u3NEZz
         xK0Pn0wYOsR6fwe3nBHi53wdGXv3GtTEFTocWhgNqY6Fzi6I+2miX0k5hPvLoFi4wB1K
         Ylmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522105; x=1759126905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tflbFhpYb7LhX1EKPWzM1vNL9oW2j1u/K47rwyVr7HA=;
        b=WcNQVEK23juCXSo/bWpAmp5k4K813ydLFWyWJ7jijAzI+sJyxDD+NryUjaXhGOz682
         o5PQH4latGf+kdukSUHCJC5bd6osskF1YDG72JyXwBwPQbzg+PMjHHY6XBzzWa9477tX
         CfxkCq2MQmvkF6l0craZwyCgCLfRxd/pjMb6Owk5CUFOGOWDTk6XmdRykhiR0/IOftLo
         ycus1oyj2kRuBjoMB2G5Yp/7lncSi6gJQTSn4tKKO5VCx8DjTGABRAYlPDnfzU9M/18m
         gc9E7pfXLWt+ZRJnFmaNSRMOrnyk6gPGIxett8GmowRJXDqwvqmwXfiaH6vMDH3YHS+A
         s06A==
X-Forwarded-Encrypted: i=1; AJvYcCVXZ+rPw46goiqG5jFvUSMQMGyXxfNEwtIYtQ+P3ZewFbu2YwfF7nKDDHDV86elFH3gfeWShUkXAHAwxb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOHFy++x3PAVoFTo2bmAolJ5/mjBSSmCmabGwqRYYTkQqveiT
	WTndYJvHlW/d9uSpRyqMEHeSEQyNqXZ6mjnffxp8KQKemFpwUCWhtepp
X-Gm-Gg: ASbGncuymQm62Fun67jvx2CuuoDyp5H1ODT7hLajAVDhy7ZroeIC0akWhVDlJFLyOHO
	EX7GhBfFmE1Pb8zWiPILuOtVurtH5NxafL/SZngU0ybd7dfHnb/1CAiE93dt05vLXDQHSPfXC1R
	89MshDjOFl8yOKnTNMVGcurlsmTEE0xEkMItRvcn/9Evn0G6Eji95PjJ9N4rIa8b9fC9VOqFcRM
	TsQO2aHwXRI8u+ySOs6uBeOVexLLQ4b5aCUM5JOdx5u18w+T/Vn0bIoxkXnaAF6s7AcMGLrmnjG
	UHxjCdkxeUIGwAx+m8cZVgzmifFmMPPKzPC8qb/ogQufnjTBgW50WcvqKvyaX3Nkbq4smDS60f3
	Vz+Q6NtomDHSjr62UmOjpf9K1kOR7DSXsYJhGOItk9HlMz830xnDkbWtMvHq57sQXm3o=
X-Google-Smtp-Source: AGHT+IGAP/9qoDwVGCmbbFJydkjjc+ZyIXD+1vfex4mQA579RdyZw8D0MQranCYlakKK9Oih5XxNiQ==
X-Received: by 2002:a2e:a553:0:b0:36b:7167:5616 with SMTP id 38308e7fff4ca-36b71675bc4mr6929961fa.36.1758522104533;
        Sun, 21 Sep 2025 23:21:44 -0700 (PDT)
Received: from [192.168.1.166] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a99e99e6sm26982661fa.56.2025.09.21.23.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 23:21:43 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 22 Sep 2025 08:20:58 +0200
Subject: [PATCH RFC 3/7] i2c: mux: add support for per channel bus
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-i2c-mux-v1-3-28c94a610930@gmail.com>
References: <20250922-i2c-mux-v1-0-28c94a610930@gmail.com>
In-Reply-To: <20250922-i2c-mux-v1-0-28c94a610930@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7882;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=UBc7AM0gSO9uZhPLncPbz9SMwH2LrhqeMCqUzN/cGpE=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo0OrY/VgoJ03b/XE53W/Fnnp6hsxPEZWuFyY6f
 vBnSPuSdf6JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaNDq2AAKCRCIgE5vWV1S
 MrkmD/9WfPS3fCHXOXE4yGJNyYvFXKN9UpVrhDhni7B6ty7jOOKH85wVttq4AMIyfLo6qIU2NOo
 jaq7UDZRrjT5KdEb5rECLnqXWVhRgv81m5zXHJFlIoz4+HMeMlZ9SuAaOXI+OVT4kckpZ6Ma1Ee
 cfRKdMuhEY94TOROSzvRWXrI+bwbVLPpBjeI3ue1wrOEPGbbfBwnduUdA+/xsrOJlcNSrxeCdal
 9IXeUHKW6eyIQX2j8qA2So3LIF6/GzPNMxdifLaIu4x8j7lStkuRvzhIR1BuKdPJ8WMMgevEmkZ
 cHX0oEx30f4GqPHyxwqbhFRDgYtQSjfP4bygPkNRKGT29Ar/1wVpHFDl+daCTC59sorkguQ3RdY
 npO6dYo2POofexUJyMkLRFYI9VWTQQJOWxJgsFt0XSaaBRYE+/mkAWqfbE3AxmKqSXqGwf9SjnW
 W0Ygrfc07saUkVWZYRkJIgKMbs82ROnB9UcBOXc8MGjXZe9vnunvlnzfk3jwHSQM9ymwNmJqrDL
 kvXmTZDFjZ+i3xQQn8gFTWO1HcfBnrIRn1T+gQ48LNlAsbiiaJ1V+mcLsM0iKZQ6pSKB5yecx/N
 1rdHH8xi/HtxRIMXJr4wWowsF9S8KKCFDPWXCapkyxXsfLsrqdUhk9eJtvx4ApVHaNE6h6hu1Ao
 7DlYHhMUf6Dil4g==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

There could be several reasons why you may need to use a certain speed
on an I2C bus. E.g.

- When several devices are attached to the bus, the speed must be
  selected according to the slowest device.

- Electrical conditions may limit the usuable speed on the bus for
  different reasons.

With an I2C multiplexer, it is possible to group the attached devices
after their preferred speed by e.g. put all "slow" devices on a separate
channel on the multiplexer.

Consider the following topology:

                      .----------. 100kHz .--------.
    .--------. 400kHz |          |--------| dev D1 |
    |  root  |--+-----| I2C MUX  |        '--------'
    '--------'  |     |          |--. 400kHz .--------.
                |     '----------'  '-------| dev D2 |
                |  .--------.               '--------'
                '--| dev D3 |
                   '--------'

One requirement with this design is that a multiplexer may only use the
same or lower bus speed as its parent.
Otherwise, if the multiplexer would have to increase the bus frequency,
then all siblings (D3 in this case) would run into a clock speed it may
not support.

The bus frequency for each channel is set in the devicetree. As the
i2c-mux bindings import the i2c-controller schema, the clock-frequency
property is already allowed.
If no clock-frequency property is set, the channel inherit their parent
bus speed.

The following example uses dt bindings to illustrate the topology above:

    i2c {
	clock-frequency = <400000>;

        i2c-mux {
            i2c@0 {
                clock-frequency = <100000>;

                D1 {
                    ...
                };
            };

            i2c@1 {
                D2 {
                  ...
                };
            };
        };

        D3 {
            ...
        }
    };

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/i2c-mux.c | 126 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 114 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 5caa927c0caae512af029f0d1ae9b7f845ba3f6f..22b404597ff91eddb965c48112fdc63250d71e43 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -36,6 +36,72 @@ struct i2c_mux_priv {
 	u32 chan_id;
 };
 
+static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	struct i2c_adapter *root;
+	int ret;
+
+	if (priv->adap.clock_hz && priv->adap.clock_hz != parent->clock_hz) {
+		root = i2c_root_adapter(&adap->dev);
+
+		/* if we are parent-locked and the root adapter is our parent,
+		 * we already have the lock we need. Otherwise take the bus lock for the root
+		 * adaper before changing bus clock.
+		 */
+		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
+			i2c_lock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
+
+		ret = i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
+
+		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
+			i2c_unlock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
+
+		if (ret < 0) {
+			dev_err(&adap->dev,
+				"Failed to set clock frequency %dHz on root adapter %s: %d\n",
+				priv->adap.clock_hz, root->name, ret);
+
+			return ret;
+		}
+	}
+
+	return muxc->select(muxc, priv->chan_id);
+}
+
+static void i2c_mux_deselect_chan(struct i2c_adapter *adap, u32 chan_id)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	struct i2c_adapter *root;
+	int ret;
+
+	if (parent->clock_hz && parent->clock_hz != priv->adap.clock_hz) {
+		root = i2c_root_adapter(&parent->dev);
+
+		/* if we are parent-locked and the root adapter is our parent,
+		 * we already have the lock we need. Otherwise take the bus lock for the root
+		 * adaper before changing bus clock.
+		 */
+		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
+			i2c_lock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
+
+		ret = i2c_adapter_set_clk_freq(root, parent->clock_hz);
+
+		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
+			i2c_unlock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
+
+		if (ret < 0)
+			return;
+	}
+
+	if (muxc->deselect)
+		muxc->deselect(muxc, priv->chan_id);
+}
+
 static int __i2c_mux_master_xfer(struct i2c_adapter *adap,
 				 struct i2c_msg msgs[], int num)
 {
@@ -46,11 +112,11 @@ static int __i2c_mux_master_xfer(struct i2c_adapter *adap,
 
 	/* Switch to the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id);
 	if (ret >= 0)
 		ret = __i2c_transfer(parent, msgs, num);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id);
 
 	return ret;
 }
@@ -65,11 +131,11 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 
 	/* Switch to the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id);
 	if (ret >= 0)
 		ret = i2c_transfer(parent, msgs, num);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id);
 
 	return ret;
 }
@@ -86,12 +152,12 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id);
 	if (ret >= 0)
 		ret = __i2c_smbus_xfer(parent, addr, flags,
 				       read_write, command, size, data);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id);
 
 	return ret;
 }
@@ -108,12 +174,12 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id);
 	if (ret >= 0)
 		ret = i2c_smbus_xfer(parent, addr, flags,
 				     read_write, command, size, data);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id);
 
 	return ret;
 }
@@ -366,6 +432,42 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 			}
 		}
 
+		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_hz);
+
+		/*
+		 * Warn if the mux adapter does not disconnect channels or
+		 * if a low-speed channel is seleced during idle.
+		 */
+		if (priv->adap.clock_hz < parent->clock_hz)
+			if (muxc->idle_state != MUX_IDLE_DISCONNECT ||
+			    muxc->idle_state == chan_id)
+				dev_warn(muxc->dev,
+					 "channel %u has improper idle state for this configuration\n",
+					 chan_id);
+
+		/*
+		 * Warn if the mux adapter is not parent-locked as
+		 * this may cause issues for some hardware topologies.
+		 */
+		if ((priv->adap.clock_hz < parent->clock_hz) && muxc->mux_locked)
+			dev_warn(muxc->dev,
+				 "channel %u is slower than parent on a non parent-locked mux\n",
+				 chan_id);
+
+		/* If the mux adapter has no clock-frequency property, inherit from parent */
+		if (!priv->adap.clock_hz)
+			priv->adap.clock_hz = parent->clock_hz;
+
+		/* We don't support mux adapters faster than their parent */
+		if (priv->adap.clock_hz > parent->clock_hz) {
+			dev_err(muxc->dev,
+				"channel (%u) is faster than parent (%u)\n",
+				chan_id, priv->adap.clock_hz, parent->clock_hz);
+
+			of_node_put(mux_node);
+			goto err_free_priv;
+		}
+
 		priv->adap.dev.of_node = child;
 		of_node_put(mux_node);
 	}

-- 
2.50.1


