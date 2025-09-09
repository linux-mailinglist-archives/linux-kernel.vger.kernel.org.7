Return-Path: <linux-kernel+bounces-807877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE0B4AAAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AB21C60520
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1331B83C;
	Tue,  9 Sep 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZh306tf"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A3318138
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413797; cv=none; b=l2BHWWicAbUVZja+PqQBxM6dcpYhh15tN+ZHaunPsRNJ04n7YLrSGZZe2XFwdYLnwNMZe5NxC5KIkykIwMGDn26dPew3sX/6Ni7OVIxewf05B5VHB9z7g2TAKzv2Ncvf8yOQdfOuAiVdMq2WpL8inXgXajmY9rfS+UrRXqrlSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413797; c=relaxed/simple;
	bh=IqiYlfOVbQa/zh50FAoJsm1nVp//uGooPnZlzF1wXek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q1qSkjomLz3+IpSo14LIenD+w5NKjx/krMwGegKc7+tXjCTjmYVa4FiDttXGogWgNaCL/6CZ0ZpNZU6ZYJ10FwDOwJEUhuQj66Odu/uJnaJCpzCpkrusd4MJNWcvps0pZqrc38JNjjv2vD/qZlI0Mq1URv0mIChNp30hnqtDK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gZh306tf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3dae49b117bso4768547f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757413794; x=1758018594; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6DLuZEXjLVaECtCo3C0mHyLZL5DvcGRCHNBQ9l3dvw=;
        b=gZh306tfVI/Vb6F1+ICCiJ9FJjx0eiFQXdGI4DoGVqLhUwulNgja9VOsQU7+uZfJ9u
         fzVbWmAW9b2zEVSBiBsYOo7N4R1FpzA60DV6aAVjL3mdXZstwfuZFgUW8spzERjZujH2
         Y0eRPRLXTc2ftk8i1o/Icd8PncFZ1Jci6cO/626B3PX1BZAMsFj7DISE7mNdFWWdwJSM
         xOV3b/CmNs77mYv5a5zqtEjo26F+3AkpIuv9Z+renrVnoMS0HTVsre+suwZcpgHMJFuT
         hgjqSdnFN4ZmoIfcRBwfKsciUqWYSNeoe9OOAxtpSq9X12eu34zZKpB1O4SKAca4vcie
         ikdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413794; x=1758018594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6DLuZEXjLVaECtCo3C0mHyLZL5DvcGRCHNBQ9l3dvw=;
        b=CBySi6ZsRJwRBHHsUoZKg+asg5Cdcat4ELJdEn8RdC5KTQkYWHE8JT7x5Jp4B+7sir
         uH4Xlm27YRaEbjzIBKtKw9XBd10AFkNf7vliQdem6gaElg+mj67yWyv3g+UjYgaULdV+
         0jZOSTKn+PvKhMz+yYiIODy2cNasVUR0HhkgZ27dHGTeqKLAMtu8nX5t/QzhyDHZWl38
         V+hV8tMOQJ3f/DRQ++pJqfTtZfJbzEF27+l+TXVb02mr3G6ECScLaOGx1Oe8zSnrxsJT
         8vegJzm9PbN1eZ0ZUYMqgQGauTOMA7l/V4da6PfshWzeSUihzb3fmhFW3I1IXepNEfPj
         chXA==
X-Forwarded-Encrypted: i=1; AJvYcCVvTJ4QarB1O+GW24E9qnANEm1xCmDmKIBgz5KHuuLJ9aORLhdaD9gPERNC7g+41toRyTbDtmP+M90u9Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPzTAzElz3IXu+dL/49GeowqDlFQ2AQAxTYR3bqisGaddp0Y/
	51MRXDkprgVRkXzUXy2Fj/afklP9JCl1AUVsV61AjsK1tYZxu+4Or6nAtrUOBVFNC1Y=
X-Gm-Gg: ASbGnctUhyMzFt0eOpPRo24+1gf63F8kqQfyngKRXs2bIRLFcdlAmSz3BPXxLZj3jzf
	huiQAHeQUTraUxT67iKukc/6ShJ1SsrhihZtA8XzfJNz6GglNqZ3DZ2gF7s8xTNkPZVCUgj4iX/
	WkI+LiX4dItqLTw3UHiuAczqlqd3W3VM+IoOvRyZg94a41sYvfi5Hh76CT5SLEupTjKR8672hsF
	UDKoK33mzmlb6xleYbwUOctFtr/2jluN83BVQ3pLMaFCd/3/7IcjoUkk9T9AmvuU9OyI8vSYFtH
	unEKbVRr04zNGWLrumVk0cy2H0qu5tRDQJXuQQocLjmy0BJzbAOuWiIODwB0wXJ7YAkwdepcIak
	49Vwh6GLA8ogdk1Qa1cQOOjFV7uE=
X-Google-Smtp-Source: AGHT+IFdlL+stSgluJu4iHh99463lMmfzZUp75gWa4DtFMccsEMf3Hiqt7K4aEcp6FbjhSixFYzjGg==
X-Received: by 2002:a05:6000:612:b0:3e7:484a:741b with SMTP id ffacd0b85a97d-3e7484a77efmr5916594f8f.41.1757413793883;
        Tue, 09 Sep 2025 03:29:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45cb5693921sm289899335e9.0.2025.09.09.03.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:29:53 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:29:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] PM / devfreq: Fix double free in
 devfreq_event_add_edev()
Message-ID: <aMABnic3SVnYMvGc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The put_device() function calls devfreq_event_release_edev() which frees
"evdev".  Calling kfree() again is a double free.

Fixes: 430a1845c804 ("PM / devfreq: Fix memory leak in devfreq_event_add_edev()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/devfreq/devfreq-event.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 34406c52b845..70219099c604 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -328,7 +328,6 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	ret = device_register(&edev->dev);
 	if (ret < 0) {
 		put_device(&edev->dev);
-		kfree(edev);
 		return ERR_PTR(ret);
 	}
 	dev_set_drvdata(&edev->dev, edev);
-- 
2.47.2


