Return-Path: <linux-kernel+bounces-828844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 673CDB959BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822F519C21FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161783218B9;
	Tue, 23 Sep 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D37FU1jK"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CC27280C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626359; cv=none; b=uc39kaB6DMaLBNhlnAyFQknciKs9nIJfp1YhU8QSxgSxT3E3/2LKc4MY152E0pfFije3ujY+FbchqxblOx5Sz7BQAM0bOlVXw+n4W1UeNhm8ShlOEkFFPEmVbGmauHtPHJ9g1R4oFUMPbYECRbNU91ofV6ljo6uWi1XcSkF8hUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626359; c=relaxed/simple;
	bh=FhrQh8wlJhkiGsJ13lu3sPHpZl+KsdORpiUvpf3eogg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vch1pmEiyTXg/l42rM3/u2INyjccPt2QxfUuh31sSe39wYaXfiG85OJQ25+9bcHdXEX+7AcY+M7qpCgOAPrBnTO+3K/CdRIEpHsp59fIW5hh+OC1x0hX5Oti0DxJeC7WqKAWBg4KuE6TFBtw7IEGamtR/jFppoO8NH/sLwSw+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D37FU1jK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso2871454f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626356; x=1759231156; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vLuVuYkRxMOaPm/QX7PGxaAYbQhLbxbW+ekIalkme8=;
        b=D37FU1jKSGczue9Dgn4zjh9Q/9VOAh+Yxhv0mQl+5nKSGCDiXZGY3pGN4lWAI7UK+K
         Sr3m8eynRP4a1FkciFF9zEdU7/0a/CSr/F/zJXyewRCuD+KRCdsshMRGIbppC1JiklEU
         i7gokirPy7078/H9d1e8jgklpRF3/NWc2xfPDSMUAT3kQzMpnQAiMPR59f1BS11i2EFW
         L2xv5ldWrCMIdDNTg6lFyBIc/HcTjXomjswdeA0ENkpgQmwCyF6nNq2RUDaxXa/Z7ntJ
         i7qeX4ioCj5dFUh6oPzktQjEn+3HFg+DoAdoqewsIrGAuCWKqUMb0lSkZIfQV92btOo3
         h+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626356; x=1759231156;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vLuVuYkRxMOaPm/QX7PGxaAYbQhLbxbW+ekIalkme8=;
        b=UmiJd9E0nb34Xy9/uZ0GaTDY9S2pnt8ugyPkZICXrLrYTROHgaygSd4CORfvxN5HSJ
         GS+MdMztznlDhJxoKYmW/YlW66xsBuvyMClahWTi05SCJWUDouMfXJSzbPq5ksKFOXP4
         nsmHTPthQJWzJqOIW7IGeXg+2ax4Ktgr3LNUbFvbUi6kmbbv0CtgFJL+vuht8C7oUZ9B
         h+bUiFPhdOwVnqIeQpPdFwzW7ajHYGhT2uet+Vsbl7/HXfBl0KlEJW/ruR7Xns9DgrF7
         Nu/eAsphGVVrImDJ1FPi0mgk9vm608KbVz+7LSoxZn8iTSwR4j6aDrejoRHP280/62TV
         9fOg==
X-Forwarded-Encrypted: i=1; AJvYcCWD7yqwn1dTqUm01pA612ZuwCRLXQeodvh7vc9lzazKQ/79aIZOiIfn6fn5EW2UO0drtAoK+JvEewncKoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZZ/yf+UkfBbI4j76u1AxRR234h3Rmik7zmDaB5ohLuQVJSHI
	aRmPveCVq8p7BvIyfiIhGlLi4ccEVa7XUo1QR55Oj/bCPFh5U5CaBJuCR1/7C4xsJP8=
X-Gm-Gg: ASbGncs1VF4CBwVzTg/7yzQ7opVMenODXqKTB5aOQH7sff1eq7PZMVYn5mlt6yqugcP
	PaJWwjGl0uC3vMYwtDgJBOKCvsOZUL7C8LjvRs8zERzPu7dnwN6agEhMDZYUgD8pnnc0YjhlObm
	NF3jr2oAXAVFXXJ8KWzCd1tuNBboh85snf0TvgNunkMK334FnmwuzOMmttcw8qi+LtjZl/rhY5a
	3ht55zojHgR4CUw7HsANh+oCEluVyAUGlkRalta36Nwtw0btXkCeavpqVkIDaDnfADeIDxfG21v
	Ik6wkbb77FckQQyxQtSNRlmNrVxIcMOUw1Ew1MmWNcHJy49tOCtpx/L+i0WmDXGcH5iifCROcn5
	yeC8Qb5WVRcTeCx0/BODYGwDqHKAT
X-Google-Smtp-Source: AGHT+IESbMFQk6ILiLYUPMLicqqy9m7l+w2rx4L3CO/8J2ovvY0DfEOMfixD2agK3xBqmlyogy/9iQ==
X-Received: by 2002:a05:6000:25c1:b0:3ee:15b4:846c with SMTP id ffacd0b85a97d-405c5ccd2bdmr1761131f8f.28.1758626355940;
        Tue, 23 Sep 2025 04:19:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee073f53c4sm24050430f8f.3.2025.09.23.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:19:15 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:19:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] octeontx2-pf: Fix potential use after free in
 otx2_tc_add_flow()
Message-ID: <aNKCL1jKwK8GRJHh@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code calls kfree_rcu(new_node, rcu) and then dereferences "new_node"
and then dereferences it on the next line.  Two lines later, we take
a mutex so I don't think this is an RCU safe region.  Re-order it to do
the dereferences before queuing up the free.

Fixes: 68fbff68dbea ("octeontx2-pf: Add police action for TC flower")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 5f80b23c5335..26a08d2cfbb1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -1326,7 +1326,6 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 free_leaf:
 	otx2_tc_del_from_flow_list(flow_cfg, new_node);
-	kfree_rcu(new_node, rcu);
 	if (new_node->is_act_police) {
 		mutex_lock(&nic->mbox.lock);
 
@@ -1346,6 +1345,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 		mutex_unlock(&nic->mbox.lock);
 	}
+	kfree_rcu(new_node, rcu);
 
 	return rc;
 }
-- 
2.51.0


