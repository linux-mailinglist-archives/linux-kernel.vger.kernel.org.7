Return-Path: <linux-kernel+bounces-816679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DC7B5770B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796AC170581
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E562A2FFDDE;
	Mon, 15 Sep 2025 10:47:43 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4912FDC21
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933263; cv=none; b=fe0Bud8zutDUemGXq/ZlSwrptARe4G8jfuoImnW5pWpTRlZfsdBteGqGXZB2kv09OGghzbsBTKAuvW9Pv3zTh/hp+jdsHNjAKVh/FN9gESSACyKkvhjADUXvQaJ5lH3BIwIytLlVodrT1cvHoaWxswKJQo3BGnbcHetDBju4VLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933263; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVXPu9cKnZNoncmcf+9X1b/4LbgtLPxxm8r+7z25bOJCLygGsvL0AWozBMMi/0reYqtrSco8vTbmcMFU/XEsOXPRdtw8nM/Cl4v6/XRLl4nYjbGWYdi28gRXgxoiSptE89W5ZLNSr8L0XJBFDFA7A7Ipjg/3dNhlSY9fpP4b9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b07883a5feeso689681866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933260; x=1758538060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=xQ3ZP5/qPYayT4Pu+R/eSIXTNzLmpZyEHWpuSWnH2n6OuY3+5FpDyTDItNFzIOTaTR
         /fheSYACi0LPFi+2pvmFHKQb8FkanH9mNqEeQoIYiugCErju+9KgJlV4T/FJMG3x/xpb
         UF9PRBIqucw1TdGEtMRL3qbnkifB2pdVecMvUCnv4F3Nqpv5Dntt8PsLkFrh8ASgsHYr
         pfyimRJYit1P5PEtQ7sR2qB5aSSG2MK7dtMNKrH0ooNdinV5x/2NPLiQc4UUCqh1taCk
         UjFx6T92WB9zVUh7hO/zvh+FU91cvQk5ej4vONKP8cSrcbrC7xp8T+PpEN98Rq+Z6Axa
         RVmg==
X-Forwarded-Encrypted: i=1; AJvYcCUWEwkK1j2pcsdfwsVsat05IYZd5bwDmC4cx7urI9RdVbrd4jatLgwDngVcpgeLFEksborU4kSK8N4hBfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9Gsl7XfejQXKgl83x7tZyViGklU/xBKT6FhbLenzujEXogK5
	37FkfN64hCRCbk3snZNFrYiFh9gKhOKFn8+X1X5U6Sic4bO12VOnYrRWzRLqEQ==
X-Gm-Gg: ASbGncsYbgIdmaWY9qKBK8+ba4hycUFS7NSiVN99VBQmIFwBsQcs/OCvaG3vWlwDPNA
	KgPgcMlASM2W6TDyPxqm8aoffjukhkhDjiLwt05ScqPQUAyncB6PSioiuqm6cxyzcnEZ02FclOk
	5T5JnVKEeYbNIeiVjNtHreei3Vz6bviCEq3j0ymDBDRXNIVRUONSHf5gmgn+xIt3lkzTYzCKPA6
	fntVQVHKMivJlRhEEZaCIjPgm4pC9bXuKpmb1Eo3okB9i0gQEk7/GUhO0OdxRsdZ5Owv16FUJqI
	ab55wl+b/LFCCfyWuDMewt/L+/N1rd58GBbWRPkQSKzNPNU75f/GrqWGMD8gGg/oZMpnTYxBQEy
	JxnUtjajh1/iBE1vYEfRnXsY=
X-Google-Smtp-Source: AGHT+IEQ9CUxEeQHE3JWeIoC8BvynW9DvSy0HF5ePZmATusnxUn9fnpDDlUTtZxfE1vunib1KQd/Pg==
X-Received: by 2002:a17:907:7ba3:b0:afe:8f0b:6c64 with SMTP id a640c23a62f3a-b07c3540a7dmr1323625466b.4.1757933259662;
        Mon, 15 Sep 2025 03:47:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d6bfa591sm572756266b.15.2025.09.15.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:26 -0700
Subject: [PATCH net-next v3 1/8] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-1-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HRQadCYc9h5GkYpniPFgfnT/0CcAEMafkT
 xuCsB2YQsuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bQfjD/4lrt/Xiz2QXAq1v5Ij3l122VUYnu57K+oaAWsTIbUswubQhe9ghZG0rlB5vBcFbKB6ifg
 h4rjFqfnxwPWw1Ya9lScsGSaUuyz4R3iBUjVcYxDzH0whPHMK4u+o+XlPNrKvA/vMu/93lfVjU7
 zuPmKBhPnqiqwv7kyA75z0SY/+ygRSDqV4Y4A8LhT0CBD1bpmMko9PHjRAznUwsfFJqmrrbQTjU
 oSjq4hxms/om1T7G93kQL3qvP/eNjEFtLQ0EyKxfHfERYKVSinEhUdRRfhQmButmHxKQKOqxVmp
 fa9yGyS2O/GmxIlU0d31loo7kOmnt/JMgcAzgjOWbzG+mewUxlhIWZo3cwfl3p6NyFAI7pnkuyx
 ouF3WNW1HTPULNnjt4Zu04Z/QfbvA+WNaYsytakafDmuCel7LNMdELoBUucOaW81PGpVtj9KX6L
 cC4j0juY+QjEwzZXZdg/P/VBkIK5FFLMwNF0ek6z+MK9cVAtmiPB3NHQGKPObQrr/shtegXW3cK
 ruSuGSdZaiC6F5DUIbpUW1EVWbNDfpIfrbSYGiXytw3SivwshUFVkvziN/q4RJoya0D4Ih/dGjp
 Ndf0Zu7KJveBQNXQ6U+f4FILMV78m68phdBBwn3BynkIEpOF0e6p39nkb2VBIRaFT9/shYVlkbq
 x5DvosIngPw6T/Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_copy_validate_indir() and callers to validate indirection
table entries against the number of RX rings as an integer instead of
accessing rx_rings->data.

This will be useful in the future, given that struct ethtool_rxnfc might
not exist for native GRXRINGS call.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b2a4d0573b38..15627afa4424f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1246,8 +1246,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 }
 
 static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
-					struct ethtool_rxnfc *rx_rings,
-					u32 size)
+				       int num_rx_rings,
+				       u32 size)
 {
 	int i;
 
@@ -1256,7 +1256,7 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 
 	/* Validate ring indices */
 	for (i = 0; i < size; i++)
-		if (indir[i] >= rx_rings->data)
+		if (indir[i] >= num_rx_rings)
 			return -EINVAL;
 
 	return 0;
@@ -1366,7 +1366,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;
@@ -1587,7 +1587,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;

-- 
2.47.3


