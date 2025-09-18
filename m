Return-Path: <linux-kernel+bounces-822451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF5B83E94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 981984E10D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C46A29B8EF;
	Thu, 18 Sep 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm3gFDaL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA72BEFFE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189033; cv=none; b=kryAwWAfSxojBUWkzsr+qmj/NwzaQ8oFhJz2Ogf1yUMVwshUNgiD0YsIV+BuED4CJ5c1+8syQXohEjmfzRbZ75r4PLjQFRPGiUO/q1IpMIPIAIVKOt2GQaanjMcjCcqI7gV9vhXgUJTdt6QGujDaNjftuVrBVlYBCUZ9Jz6IJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189033; c=relaxed/simple;
	bh=qHLJX/TtpVtJetIsYqyBWRD9Yy9lM9oH0njdixetFrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j6FFrNM2Nc97yDxasSg0PyHK+CnKAJd4+4KjYGPWIyWjQwc6LWxQYSWXcZWYHKXyTf7sukLfAgCyCVWO24CXtbnQdPYeujyB3sODM8i7SQra+WA6D/tCBBIBa2g9PvnhQb9vvOddp55gpruuwnrypl+JPiTQ1sZfsivEa6h8+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cm3gFDaL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso781739f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758189030; x=1758793830; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQwKqTQzxVu8vPTkPS6AVCaGBlFPjm0mxCJ88MPBe7I=;
        b=cm3gFDaL0oJjGb4Xa0O12OWm/ZzkJJkpTchRc9XSNEEJ5168AitPEYTZ9qx2o+JwZd
         7RBIwOka/wkQCsAlYtbCIIBftfAlh0vey9KBFPKllUZ/Z1aLPei0elc78W3zC+1zWBgS
         /j+Ypdpr/gxDpgzQ6q/MN3ii18TXCQWm4dIz5Zzz9eZ0jX5FallIpoNldIIJH60RfYug
         N0yH0DFaOeTGPnv70Jq8USf8GQF+fU3zuQhjXbZgcaZobO7oxMoQnZDblht5HHk3RzpO
         GGDO1IuNZ3V0Cd9OOOOxTTbmO6u7vAypoos5ojI65P2QQENXYRoVV7Dytm1N/Nk6ExE/
         mmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189030; x=1758793830;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQwKqTQzxVu8vPTkPS6AVCaGBlFPjm0mxCJ88MPBe7I=;
        b=UWQpsCZ/41TnPGidhNGQyg014KWvjt65FvPy8qgcCTncRdCw8q0VPsVNQ/pWrafCvw
         XCxYETU88SIsQOvzKuL0VKjMLQHMOuqTSt9hOxSmhJ3S7TJlP9/eT92PbsIFInj7SdyG
         kHBgJC6CI+m9OTIv1YFh1YN5RWHcOggOsYcNXw2U8tXFz1H0mgHVXP3eO8Li8e0fwlru
         6fBTQJ7RztuvoKkmqf6kIB7Ly9cafcI50eFvWJBjOBK97wGk6BTHZsr71Io1eNSzV0/4
         NqZBxDhWETqkMvnxSTheLZ0t1fqx2fKLni+yNASR5oGKd5k4wZ1LVHOV7sp5yktjOxu8
         D1ug==
X-Forwarded-Encrypted: i=1; AJvYcCWHmSdgyXM17tuKiIPblqs7DGCDycCdFdgUb4/Q7mBwhgCHaxPn759EEg44jh8IzXAvrUR3JlSiaWJntvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNid6zUO860uYnWuqfkYmMtu0DJP89Ia8B4RE5ptFfJjrKi0jR
	LMoS1Men0bxR9dEoqCECiLaJul0O3xe1Uu5X5yzVu4TgRpfvC+evW1D96jQgu9q79vm6ZBM3xPN
	Vbluj
X-Gm-Gg: ASbGncuOBX5JkXiwUQR8eSaiSB5rCHa76l6X4B+NCHgAlcJCxCTYSOwveQM/WzdE50z
	TRSyomP4rRJFVC0Z9jXVjTczwrxec/NkuBCzUlvhLFTRMYseJI1a7izT+wQ85ipsWOLYfA8wuPp
	WJkuzMH2QDyeaJDtEs925kSxdNW0lRIf+5sqW86Cyxo+WRRJStQCe6mHvbaxQm0KRltliR2FZQm
	Fgl7rU5zhWUWlz2v6oprEvJnNcAOsei7n84MWUhuCTjywpdcBTnZc1GOoGnq/RQVdguQSjTWwGg
	a6VcGAjOSBKp8efk3j+NRahaICowdNxEjemvuM+sflYvwVFbrWbBr7p3LWaEZx7cgG6swVZyI0o
	K7dW1C/utNgqVNXF/JxK3yT43m9ZdMyyt7pDk6Ho+ol5cyQ==
X-Google-Smtp-Source: AGHT+IGoCMIZSYVGVdr+LonBDIWcYYTv19TLhpipu3kLj9HY+JsSF6G9ZNs6lLtq6lsBFQeD0PjV6w==
X-Received: by 2002:a05:6000:1a8e:b0:3e7:ff70:1b41 with SMTP id ffacd0b85a97d-3ecdf9c9fc7mr4630089f8f.25.1758189030108;
        Thu, 18 Sep 2025 02:50:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbc7107sm3078259f8f.30.2025.09.18.02.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:50:29 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:50:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] tee: qcom: prevent potential off by one read
Message-ID: <aMvV4kK386Sni10i@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Re-order these checks to check if "i" is a valid array index before using
it.  This prevents a potential off by one read access.

Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tee/qcomtee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index cc17a48d0ab7..ac134452cc9c 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
 	}
 
 	/* Release any IO and OO objects not processed. */
-	for (; u[i].type && i < num_params; i++) {
+	for (; i < num_params && u[i].type; i++) {
 		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
 		    u[i].type == QCOMTEE_ARG_TYPE_IO)
 			qcomtee_object_put(u[i].o);
-- 
2.51.0


