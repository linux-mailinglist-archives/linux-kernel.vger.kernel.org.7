Return-Path: <linux-kernel+bounces-791762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D6B3BB99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A2E1717F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972B31A071;
	Fri, 29 Aug 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8m+6EET"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A484315F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471715; cv=none; b=jYs5pXodSzjinBLuGOaMViNLiy0No6iz+jwCN0xB2V+bXVzZWxAQQqPOHdJFm0HNDI4NZWngGdmfym7t3IblfZwt2D9w4RvWTnokiP6nJsQiXgS4mZ3Uk6h8oGWbLveUHK1J0CAwF3Pf2ks8+JgGOryiS752PQinEr+AjlCVTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471715; c=relaxed/simple;
	bh=PfM+wt4euQRDG6Ic7JsVFJRNm83TNiaN/c0Z+WZKFlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU6Vb/RuWbsYUFM0hOi21bak7GKxl3YKDkpb4HOhiozOvKYvcTo2oR6iTF+3cAshTs1PDLGQE83Cgi9Mu/SpK+KI4JAyuAJlHD7IeLPhoHpptCWrUBXnS75h7I3ECbP9rsBMBjWwupe4D7a6X0D6HsPq9KbxoY1d0riDpLl2Kug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A8m+6EET; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3cdc54cabb1so800754f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756471712; x=1757076512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTM2+VDKikHtSeaCiymICMXcXjx2xNcBiPL91bhKQr0=;
        b=A8m+6EETCukGWs21sDBCad6TupbQKbf8Rfc6aQhFQmN2ozdj3kOOYF6KrJjSCoSCjC
         ZvSQ5Hd94xrtz4VeRUhwgIHmz1n5ifx8OzeJNw9QUUWQIt+4a+MSSD1o0GNa/RAQ4MHU
         4Fww5dzYZqVU9iDpjsLOZoEfkM7beHxT1UihhTiieP4aL6L5VpOf+eqWVk/oDOXmLixq
         /1KP0WnHJlOqShiqITDDbmgQSureHKiVQSz4z1yCN5kZsA/GrbEBxv751at1sDTqKKlj
         S5w+Xq683qpjRxSHyqLYiZ/aHkebOVd5WTg7eBJ2XJI+RtfR4Y12m88RYdP1Iei45mgn
         g3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471712; x=1757076512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTM2+VDKikHtSeaCiymICMXcXjx2xNcBiPL91bhKQr0=;
        b=eAexQs/nvTWBkwRlM1VVF26E8yeO7iruzCcCPyo7Dr0WXDipcNXQpR4IL2c4QXmdEF
         kqReE3ynIZvH5A3pXP3bNEuM2ylbaov9KJoiAOBy1CMd+rpDckO0H5tHI0Wx8HunBski
         +0lv+ks+58ufEofSIWOWVjs06Sl+tI0hgHjmIuifec+8n7BIxrz/yk1ZN1a+5oyZC8Yk
         SbSzRDhIbid+oyzHw/Gc0st6Kb6MevNd9XBh5XMqwUwvUOb+FmhZAfDB/m3Q/b1UlSPG
         TfBP2qIR0MxPzvPMxVd+i+fSB21I8l9WLuGJvZLJIdDGOhuz4M7ZPEWi9glE6Oi0VFWM
         81yA==
X-Forwarded-Encrypted: i=1; AJvYcCUB+8+bTUBzbQDPCCgHaglq8hv2g3m5OJGu+5iRgoNVVYX8y7AHFBvvXoUcLyvNTJcaxQu3FHHVfpXr5Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AarUMoyefjfMoo+VBLaxkpXZGm721tWDYmEIO6vnwg2yUPDn
	lbLXLECIup1snJZ+IXPK35OtD+UYwpFJcu14Nemt90jQB3i0QLbGYIGO1q+Br5ZgjqE=
X-Gm-Gg: ASbGnct8S5LygYWJz3Zh8haNHnljA4y+RPZVajaU0z0mRyUvTm1rvSK3WU4fQKOQ/jb
	98dNK7HYVcY+BkT9omBatzHnqc9qO/I6tvxE3qzfXA+Ki5rS9q9aaMSBTcmPIZd6K3FqCgx0AC+
	De1T82DYEfe6ZZfXPPRxqU84W457FzZFhe3HJ8KGZn3vZ+NKPVwXSuMVjkmRY7yUb0rdGnqjygN
	s2hRTv0qVJ17Io9vhQ1G29WKAd+eaDUWvkt+PK3vTDhRCrukGJ9legyBhMmMvCnn5a2B31G/laO
	EHQAbbDc1o0yG/1Ft1Y4izSDJviL0j3CgVnL/2w+ndIsqvYHg54t7B47gWq8Ee4BPXoXJYd4ejv
	Hz62NEzvmrlcl2GEJCevc5CHLeCM=
X-Google-Smtp-Source: AGHT+IEt7FoZ+poRNkadPvFS4MiTQw46m2z3gSirCmxuvzO0nDj/MLzNGlzo9GuQ50LaspKQ2QDy4A==
X-Received: by 2002:a5d:5d0b:0:b0:3cd:edee:c7f1 with SMTP id ffacd0b85a97d-3cdedeecb38mr5773224f8f.56.1756471712413;
        Fri, 29 Aug 2025 05:48:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf270fbd01sm3392325f8f.13.2025.08.29.05.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:48:31 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:48:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Solomon Peachy <pizza@shaftnet.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] wifi: cw1200: cap SSID length in cw1200_do_join()
Message-ID: <e91fb43fcedc4893b604dfb973131661510901a7.1756456951.git.dan.carpenter@linaro.org>
References: <cover.1756456951.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756456951.git.dan.carpenter@linaro.org>

If the ssidie[1] length is more that 32 it leads to memory corruption.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/st/cw1200/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index b1dd76e8aecb..5d8eaa700779 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -1291,7 +1291,7 @@ static void cw1200_do_join(struct cw1200_common *priv)
 		rcu_read_lock();
 		ssidie = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
 		if (ssidie) {
-			join.ssid_len = ssidie[1];
+			join.ssid_len = min(ssidie[1], IEEE80211_MAX_SSID_LEN);
 			memcpy(join.ssid, &ssidie[2], join.ssid_len);
 		}
 		rcu_read_unlock();
-- 
2.47.2


