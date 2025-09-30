Return-Path: <linux-kernel+bounces-837662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FA4BACDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545B019277C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A82FD1B7;
	Tue, 30 Sep 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjUTjdQT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6F2FC86C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235727; cv=none; b=NI9sc9I4p/2SCjbyxeXpf/0sD+B7HU/YpuvxfQ8W2vSmDAm1U/cMXKAyZz1hnQsKH6xdVFTWOnYZxlJbNHvHguVrgmA+Ylie1K7sPdDNFH9ERZYJOVsw0kHEIaI4Ce4udvjXWoGfXmFRWpcsEvk+wPQPVLauEvqY4QWutaGUTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235727; c=relaxed/simple;
	bh=yM6tDmlWt1WChkIFaTtxrLwmPUG8oTR6CTdlN35Dv4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=laBGRF+a9vH8aWRCOnY2m0es4YS6so0fwT9dX+3r/eUhsC64BqUptJbNu0DQtjRverVvp3xihlfDxd4v9ciiYD7JpPHtQdyyOQ+BN3FZfUQFEnvy69zfpOq14/Am7YpvTOF+cXLyQyrmHJmtgR3M6mcKb+uf6nY7bcFnb5RpTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjUTjdQT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso4522511f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235723; x=1759840523; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+weuOFR11RTE73x7k9JMqdyo0oGBleP6ZLjJS43ihs=;
        b=tjUTjdQTA4Ioh9a3kzYTjg0MIPt81iEf9pP5ONRdYWEXfeFrHKNmviNXrouOM2PoDC
         pUX0eBBhg5MYgAoqHZEGt5VcnHgNudKd3CEpNIcgL/1aZzh89H7rmf86dt27lQJ2jnXJ
         NK4eRiPkIIM3JQaxswtjjnqdkCMje3n8qai7ZURH4IAJm2v8nfV8NeVUxftG6sY5qVNY
         kECUvwaRRl8COZqCxtkPmoRDG/3WJJsAFob5CboGVD5RAAdCcXP+idujMCKhj4Vp9Mog
         WDv9M0hMwSAoWSXLgaEYL3BZ/PsIROhC7OFoDahhdyWYKocCXLuV7vU2uWGkNIuK3IWN
         JGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235723; x=1759840523;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+weuOFR11RTE73x7k9JMqdyo0oGBleP6ZLjJS43ihs=;
        b=DsJNCnXgOhX+YNujWZkDmZ55QpFLpJefC33cVXHDmL3YkhdpYMtfBUqV9VWeOYoFqW
         I+MTlUcbO4R5o7nTntmzyI9hP8wjYi3UszTIedQdRF6fQU8ym7hMq5F4oezuTPCKzyVa
         9rOalwZYi47ZpEPLb+WKGGVW/CcJ3Uq+JUctwMbILddJqR37QWdKv7VH1LyM6jSi5eF9
         B0tcLqZEXmlliWakCSmdLj77+9V4Rq1LKKxF9jjRy7e0s2Zo1Al/JHCrJRV945ITyPEc
         ZmOWfl7+bgHL1LUXN+xmk6L2Vae1tbRQEX1DGBlPscKliAz5tBTBDBSPHMyvzxK2wxCq
         oW7A==
X-Forwarded-Encrypted: i=1; AJvYcCVcxQP/0TrlfrruMtqqbrUd+0ubsJupfTpbIsF17VxlWl4KPSEg1XGvQo3iXuTyBObF/Id0dqpt7wew6Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39wQDmXIyn3zDNvKsZ2bnz9O7dk/6lOMW4Ny2enGsuT4JLQMa
	8BUi4oxuD2fFA9ydefD0LEp8rYlXH8l0RVp6KaU+wYWkqbbn0EJv/w7zEcGj0QC2FoDLoHlU3O4
	OJ5e5
X-Gm-Gg: ASbGnctmqKq4IUaJChCZQCfR3G0zF5X+U1Wf57Afi1mcigM/An5Ptc916Rc2p1abIjx
	QhGSH+a/TndpkpJoD3BwX0lC280u+AzJfcZoyO+BO8cmE+ad4IiwcGVQBkQipl9sEfajeYrIdHs
	ybJoLqvRjA7ZjEK6hhho9Ngx/+1AC6WcIQ5RpKvljXD+PXTIfmxSjTBWbINongGzXotmgh7qHiJ
	E04Jd6HjzNAz5MnWoTjoQ9TdqGa6FiDviIucf7gwJTJj7EGD5rHhT05p6mXTeHvGmaqMQc9t5pf
	faTpKdfAdD9qNfwug795G6Uxd+7xjQOQaPROEGd5M2o3Drp9BnncTB4up3hPFQnmpO/wLwpUVq/
	Eyx/cJUv0yOPqzOqEMXxoPl7bXPJ3SAQqSspVU6FrAbict7Sw8+lF
X-Google-Smtp-Source: AGHT+IExzhhRL4g0b5oYQkaGb8IxC1lzH1rFGpLqAVr20/EVyM1DlA4fKgF6AkHr74LMf2fRuZuupA==
X-Received: by 2002:a05:6000:200f:b0:424:2275:63cd with SMTP id ffacd0b85a97d-42422756535mr2370130f8f.48.1759235722774;
        Tue, 30 Sep 2025 05:35:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-41f0c467ecasm9793567f8f.38.2025.09.30.05.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:35:22 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:35:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] rndis_host: Check for integer overflows in
 rndis_rx_fixup()
Message-ID: <aNvOh3f2B5g0eeRC@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "data_offset" and "data_len" values come from received skb->data so
we don't trust them.  They are u32 types. Check that the "data_offset +
data_len + 8" addition does not have an integer overflow.

Fixes: 64e049102d3d ("[PATCH] USB: usbnet (8/9) module for RNDIS devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/usb/rndis_host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29c8f..913aca6ff434 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -513,8 +513,9 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		data_len = le32_to_cpu(hdr->data_len);
 
 		/* don't choke if we see oob, per-packet data, etc */
-		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len
-				|| (data_offset + data_len + 8) > msg_len)) {
+		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len ||
+				size_add(data_offset, data_len) > U32_MAX - 8 ||
+				(data_offset + data_len + 8) > msg_len)) {
 			dev->net->stats.rx_frame_errors++;
 			netdev_dbg(dev->net, "bad rndis message %d/%d/%d/%d, len %d\n",
 				   le32_to_cpu(hdr->msg_type),
-- 
2.51.0


