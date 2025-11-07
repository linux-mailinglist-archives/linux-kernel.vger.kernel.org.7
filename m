Return-Path: <linux-kernel+bounces-890221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 649FEC3F869
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FABC4F3F02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D6314D06;
	Fri,  7 Nov 2025 10:37:13 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F32F6189
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511833; cv=none; b=jYJFm+BiioU6wiLgdVgApPJLKluujnqt+FeBTKhfE8C6jNS1AMEY8O3ITTj6Br2keizbymFk3f96VM1WTqNRnExhxJRfK9vRRCX+PlGcWTj23uljV0Kj/Fv7LZxyEdEb9aHKEPtHBY+oyCGXolfEfA8w1YI6+zZ8Xm33SX5pD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511833; c=relaxed/simple;
	bh=eMf/eH5g9+qHAMb+8wJaNUcxZgYuiICqmFLPZFnpo4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O1WMMcsFD/EFkRZWYKHAQdRD5lUom4eLW/B+ryeC+d1fhE+1+6W+mPSJ3s19NdhwSmSAlb5ziKYDqlRTFwjnBjhx0dDfXL46t3Q6vgOGERl5OF9lyLr8OaKXdhFt7huYWO6AqUxzymT23b0na8BMgvNGYLNvoATfy30gJ0JmG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b727f330dd2so87920866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511828; x=1763116628;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYxPX39aiXPG9LpO5fBpAwbvm12lOvNOQqkacwnET/I=;
        b=dpWrP1BA36zaoI4SkuAcMX/NUSA6EtRqcDJ53yxqVI2TcsLARoLYRay4mhUd2dPJqh
         yFUXgJv8p+W0BR1NMPe/KK4/kvHZj1tJtpwrLIBt2zarkzMUrIkFoivhY5DXWLWItXVY
         zebaPcx8mYgwXb+TXCBSrRtL6OhZ1CPkGHPsaWInOiLKdx2wuR2Fb/0zyAn7lEH1JADC
         98vl+0aVLiWmli9TpsDHEC3ln23q7uXA7Sl5sRhk/Hb2vXDffRbF6IL70TOiwZsnA6vy
         3CRRAnbtfIY/CjEQfTs09/1KePA+oWJwMdaTnLAyJjB3qbN3dbNqDEHJBX//vJK5pIOW
         59qw==
X-Forwarded-Encrypted: i=1; AJvYcCUFef4fSIexb4PsTGgihFtOOu5SgeJTBOK0vm3XlX5T68g9EXLwwOEw4XR2IIoGW9HYrqawC+YobLZwA/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ZYovNVdliYvJUoC2z4LGw0tQXkTv/Vm6LiYeISpvcRi+4KLY
	aEeWccKY9weUgNvTKBEU7a6FCDiCRLIHfBIlIoWHC4REo/B11urhDw6O
X-Gm-Gg: ASbGnct2H+hcBkAw3rv63qdStPWNF/ZScJFngvDFTBj0AXBDHnaFdVRsWRouLX6rGjx
	LpP6CI7s8B55HIIHuzCUkxLtE3oA6+M8Axxci1+9VqMUM21Sies6MibT1AVC6ziXCcs3g54OT33
	ZxI+9170zbO0WeiST0OvlQWaIg6DAFDh0JwUQp1kx054vZgYf9J5r96aGwW7heTh3fTROp+R8EC
	OCNZTOxE+YShJJOt0QqzMMHj0fjeiPmLEzGxzjfCyY74Fq4awQTu2+WjyMs2Lj6TPz29Fw5ONYf
	C1sXAo8V23nz2jX/XVhjtOPnyDkjxFhXFx50mIpqs2ZY1u82/iDaFoDQy+qHlxGMeABkI4Ix7sc
	AxaDc6JgoQqw8jSOdJLuJk7W2kCuPTzFNHqLuEiNXe+7nLKT7mlWEQuIs6fN7t2dSPDNUoJ7Bt2
	SQ
X-Google-Smtp-Source: AGHT+IHspdoeRYSgkuMSLcqAikqjJkVsvNpM0VSajCVJYUAsUVB3DD3T7XeSecb7Mxuf0FOhKTcU7Q==
X-Received: by 2002:a17:907:7f26:b0:b5c:835d:8d2a with SMTP id a640c23a62f3a-b72c092858bmr300722366b.15.1762511828356;
        Fri, 07 Nov 2025 02:37:08 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf980112sm204583766b.40.2025.11.07.02.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:37:07 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Nov 2025 02:36:59 -0800
Subject: [PATCH net-next] tg3: Fix num of RX queues being reported by
 ethtool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-tg3_counts-v1-1-337fe5c8ccb7@debian.org>
X-B4-Tracking: v=1; b=H4sIAMrLDWkC/x3MQQqDMBAF0KsMf23ARLRtrlKKaDLa2YwliUWQ3
 F3wHeCdyJyEMzydSPyXLJvCk20I4TvpykYiPMG1rre2fZiydmPYdi3ZvPqnczzEZZgDGsIv8SL
 Hnb2hXIzyUfCp9QJZAQ7SZgAAAA==
X-Change-ID: 20251107-tg3_counts-95822e6df6bc
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 Michael Chan <michael.chan@broadcom.com>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=leitao@debian.org;
 h=from:subject:message-id; bh=eMf/eH5g9+qHAMb+8wJaNUcxZgYuiICqmFLPZFnpo4s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDcvS2ZNuAaHikm+jUDd5hWH3bnoEtJvSSMXC/
 h1DfqotJ4SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQ3L0gAKCRA1o5Of/Hh3
 bR9LEAChuJJn+gSKpu642uFSOYhLg5VmxV7dogz+nKSv7HKlDkfVsAyysneU9k3Q2rsM+/nXfYI
 Tww9Xr2HjUIS/SyxrF9lYT+GcwJnVNPXc96mV70mL+W0Ex0pJvXNF/y5U4Gyz4yhlQnSPps5ElC
 lf3w1J9wRhTdE1xOpvymF79jpjK9HvfOo8t/AqPzF+JdDpKEXuJWhVCyTySmOAcjObi4tRgBG3k
 r2KZAYnKMqD1rVBmIKX7RYoYvVG3JaG8GirQ4DB6hYA/ik7f5xyYY//QajMDRT01rossbzJE1I1
 txALD0imLrg+osQO+oBmKwKt9NjWmq7S/fmXzESoRqCpvWa0cGwKeqVKA/sZzut7cM0zTjFz3jr
 ++brtuBRaHIvxa17M8Ih8MFCPqymRhqFCfntwV6Znh8ftn9LoTM/awdXkFjYPheYN66qbsCD0SK
 Q61cogyFw4l7j3oKeK4BQ6GqLr/Kcq6ex7/QetXNGdjLuqww+a7Cn45FtYUb3YzcCWWoppjS4ok
 REagAT2s1vP+NydpicJSwk2++lNT366QJ5nTFN5af1FvRmbuX5uOCtaYS4Q7uxXlkX+bPuWBenr
 P2AKfFpy+aQpXQtDHHlJEMjVwN4JqmaqCBe/Xl4iVwTsENeKnYcwRnJ6kanJlh+v82BbuaaJgqT
 G71kGjxJJnr8WsA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Using num_online_cpus() to report number of queues is actually not
correct, as reported by Michael[1].

netif_get_num_default_rss_queues() was used to replace num_online_cpus()
in the past, but tg3 ethtool callbacks didn't get converted. Doing it
now.

Link: https://lore.kernel.org/all/CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com/#t [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
Suggested-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index fa58c3ffceb06..e21f7c6a6de70 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12729,7 +12729,7 @@ static u32 tg3_get_rx_ring_count(struct net_device *dev)
 	if (netif_running(tp->dev))
 		return tp->rxq_cnt;
 
-	return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);
+	return min_t(u32, netif_get_num_default_rss_queues(), tp->rxq_max);
 }
 
 static u32 tg3_get_rxfh_indir_size(struct net_device *dev)

---
base-commit: 6fc33710cd6c55397e606eeb544bdf56ee87aae5
change-id: 20251107-tg3_counts-95822e6df6bc

Best regards,
--  
Breno Leitao <leitao@debian.org>


