Return-Path: <linux-kernel+bounces-814638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE43B556CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AEEAE059D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DA5338F56;
	Fri, 12 Sep 2025 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JVv1enHC"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78315334723
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704215; cv=none; b=nCBWDxpfrQrcaVvLxW2teIIky3nHs0yb1Om4ew0p/y8Cj82ojjp5R70N2QjcUxamsmu083rQEWFjLbWL8fdGJqVVyA9bDy4JAn4ST4uZvDPugnnEScqT6ppaVqgMycUaE9StWz54BMUDZaovrP08zLF74W25G4FLbcLlzQexiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704215; c=relaxed/simple;
	bh=v0NAW7Y8Tgsq4aoIScefhPV46tEnXeycoysRScmk0Ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JogW7VDaE6wkOf2/kpFwFnlB4NDvOXW0EhLXEt4lU72HB93jFX1qxxFdd9pDOZCf0oue/lcLX9lLheQZkD5CTW+FnPAsGSonvrJzvmqq9S8bz0lfVFM+kIAA9v+9E9cJrwnTugbKvntFfwsWzj93WRkdnkIhv5LfnuuV5fxjodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JVv1enHC; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-314f332e064so678464fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757704211; x=1758309011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SljH0VYmnL+jw/umeaevbM/CplB5Kc7vt0YrqGHjMOw=;
        b=JVv1enHCX40KAlU+9Np81K8mGk0fslyARTuo5f77iyiXLvkHX9fYOPwtsyewabsZKG
         nuZ5ytEvnAzNq7u6ydT39OLpzci9rNmKgGa5sVuTPCjOh9aqmQsPJsZLpg0aFlYaoJe6
         xfnlFsnzCaA6Z6Q17115jYmhVCjiFwLEpJiML6JZHLhhpGp/X1MQG8sHzznGbDXZusak
         5/OncdsSAjwb1CvHun7IKtf4Pmbopu2+955sHTVIdkecAUzaIWPY114kUhefRBm114l9
         RsL5UEvm22qR7eIzfX1TUUPDhM8kNKv54W7mqeudFU55BGpmikvI4Hzck2fBclJogdIG
         f2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704211; x=1758309011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SljH0VYmnL+jw/umeaevbM/CplB5Kc7vt0YrqGHjMOw=;
        b=mh3DYRpDgXt7ZKpN3/haYisvhxIkRREVWLS6uVF05FDX2lobsgN11prDpi9XiNqaAV
         dNQr/5HaYrhtFMrO2g75LyY5Qeuiys0j8sGkvzAYz0mvHr0a/0E4VMRjsP+uBoAI5qtz
         4W60RL/SDHyspl74TpynP7ghrRy3wtIgViA20pKuN2w3E8zdTGdtSV6F3iGrPSp+JKvA
         YxW5Jm6+Zaiw9zC7fSiuCb2lIip0hCfcOsgtVAnb1zdMABH5jhafj4PeKTgWHM2nx26/
         MrtsEBD4cIu7lAuQ2ACJJVrUHBO8ZZ7wgAD0fc9FNE15+OH43bcRaJRxgA/52+EGnBJE
         +7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX6y0uM1bBIolg5j58KLK0pSY+51U0dePHi6LKBVJSnTR4OGOakqaIDqR0vV6UULc0AsKSab2kl40Bwgy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0hibEG9tzPArJQTd5nnWqKjFpkvSwa4ydSutvUw7I32FuwAw
	MSG+mUeb4+f5nGY9GZqhauGeN7l29AvPZ71iIO67RvvBrOHVmOS2L5/CorylK/o4noc=
X-Gm-Gg: ASbGncsRPzo0BdIrRabN/SEsRgzb3RmMDbeBujQh+OmF8eQjQq9NTnT7qQ8nIT+N1bH
	Kvel4ZvPUqAgem9Xu1qplwO23h1nxFKSONWytKgzjzgMWpnxGNr0UKQ7D1lnLQMJzOId5PMr1b0
	8yvrvss1aVsSUlpsPiPbtJAvPcAqrEv/cFrgXvnrFg9vEmYRI0EOFROyA8HH0kDAX8/Ip49fDcE
	+2hWExPexpdJky7KbiqcaXfjK8fmyoh+lvFzM+eubFt5XJP0Mok3BheZDw3Q/BmLxIzAYPJXj/J
	+ORfChK7b6aICvGhJ+/aRVWMQrZeI1Xof9iIYgHR2dXtIOEPGvn4tTigTP65mFHmJEP1Q/2XlFu
	ITuAc4lFAgM5rGyNz0AtT6CkIErjm
X-Google-Smtp-Source: AGHT+IEYjasC71hvolYSLo91FNK0i9nF7WGqfhNiYnif0y60U/+XyYVSlNOqywPPuiBlSiC58D8CQw==
X-Received: by 2002:a05:6870:7025:b0:319:c3d3:21bf with SMTP id 586e51a60fabf-32e58042ba5mr1841846fac.47.1757704210771;
        Fri, 12 Sep 2025 12:10:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986c872sm1172564a34.15.2025.09.12.12.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:10:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 14:09:31 -0500
Subject: [PATCH v2 2/4] iio: adc: ad7173: rename odr field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-iio-adc-ad7137-add-filter-support-v2-2-bd32dfa3d761@baylibre.com>
References: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
In-Reply-To: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3394; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=v0NAW7Y8Tgsq4aoIScefhPV46tEnXeycoysRScmk0Ec=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxG/8/RmUXg0ZY9kb6HJ+04aymbzF6MgReJoOd
 mxl9Et7JhCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRv/AAKCRDCzCAB/wGP
 wEK6B/9XK4C0R9w7TaO5OCYGHStxfDUkSTiahti8qnURv+f38LAF6wW8pa/2Aa+lrAL3ucWnDF3
 8SQ/8hSVRsp2BwqNuV/E4w9jodb/+8Fww+IQ47pWh/hzaE3gDpsWM3S2pl2nVDmsbPsXDstmvas
 rFUeOJT83UQBEkbVZOla2p3W0DCak23ezrH+IzE8Kj7qauWahHbtCLBGqVGeXFNk3rv7trbqtAe
 jC9yeU/tn59wrxQZyTFQe0FlLNP4JBHQZ8zif2vJ8Z+IbCLI8Bwtmrat+MUaRa8adLLs9UxAdf2
 b6X1lYCDYaqWDE9KU8K4Rbx1nsBlqJfsGEuk/W4mAlSQX3jY
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rename odr to sinc5_odr_index in the channel setup structure. In a
following commit, we will be adding a separate odr field for when the
sinc3 filter is used instead so having sinc5 in the name will help
avoid confusion. And _index makes it more clear that this is an index
of the sinc5_data_rates array and not the output data rate itself.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index df586cb8f09ccc6d1647c66fdb9f147c0b4694b8..80734ae25f9df31d846e242ab7142251e4ee588d 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -205,7 +205,7 @@ struct ad7173_channel_config {
 	struct_group(config_props,
 		bool bipolar;
 		bool input_buf;
-		u8 odr;
+		u8 sinc5_odr_index;
 		u8 ref_sel;
 	);
 };
@@ -582,13 +582,13 @@ static bool ad7173_setup_equal(const struct ad7173_channel_config *cfg1,
 		      sizeof(struct {
 				     bool bipolar;
 				     bool input_buf;
-				     u8 odr;
+				     u8 sinc5_odr_index;
 				     u8 ref_sel;
 			     }));
 
 	return cfg1->bipolar == cfg2->bipolar &&
 	       cfg1->input_buf == cfg2->input_buf &&
-	       cfg1->odr == cfg2->odr &&
+	       cfg1->sinc5_odr_index == cfg2->sinc5_odr_index &&
 	       cfg1->ref_sel == cfg2->ref_sel;
 }
 
@@ -650,7 +650,7 @@ static int ad7173_load_config(struct ad7173_state *st,
 		return ret;
 
 	return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
-			       AD7173_FILTER_ODR0_MASK & cfg->odr);
+			       AD7173_FILTER_ODR0_MASK & cfg->sinc5_odr_index);
 }
 
 static int ad7173_config_channel(struct ad7173_state *st, int addr)
@@ -1183,7 +1183,7 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		reg = st->channels[chan->address].cfg.odr;
+		reg = st->channels[chan->address].cfg.sinc5_odr_index;
 
 		*val = st->info->sinc5_data_rates[reg] / MILLI;
 		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO / MILLI);
@@ -1229,7 +1229,7 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 				break;
 
 		cfg = &st->channels[chan->address].cfg;
-		cfg->odr = i;
+		cfg->sinc5_odr_index = i;
 		cfg->live = false;
 		break;
 
@@ -1655,7 +1655,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
-		chan_st_priv->cfg.odr = st->info->odr_start_value;
+		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		if (st->info->data_reg_only_16bit)
@@ -1727,7 +1727,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->scan_index = chan_index;
 		chan->channel = ain[0];
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
-		chan_st_priv->cfg.odr = st->info->odr_start_value;
+		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");

-- 
2.43.0


