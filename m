Return-Path: <linux-kernel+bounces-775309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34795B2BDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FEB3ABB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D546231A057;
	Tue, 19 Aug 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jy/ruT42"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D41E5B60
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596518; cv=none; b=n9DzivNftq4xsiMtS4Dz0Jq/YROW835PEqJUn3EzEVKpr12ThcONaNwX0wPK1EbJG+nyJ7+jPQCHLzVsM4FZQ+goDlyovn6TyTN0JIrgRqsRAdHPxJ5npD269cju1RwCHoJQaRxSsTduGV5nrUjaRjBLmivCAovo7CDCGAVaCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596518; c=relaxed/simple;
	bh=Rn+8s1z9P5Tpkw9T71JqBJFM5aF2BjvuA2JqLXFJzxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lWyJWyZO1qj6xG1MREhNUjMbXPxTPK8ejIgg2C0ZdYqrYl0FLDe2BMEZ9HDNrUVcq8aPpW0LpGHa1/TXAF9LtUfdabHmKekRSpqZgL5qMFRNFe8+exKlfv2n/0P6XA2Gz4o7UhWa+GMg1MAdc5NLgMJp56PcqXOqI3sPprZB3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jy/ruT42; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9d41bea3cso5400754f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596515; x=1756201315; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVLLl9OqNk7Zu3EPzfXMDRVe4XrWiVodoUaeSDsMNj8=;
        b=jy/ruT42PnzyoSFxgOw03yjg6ghYeio7M8XRTStzj/dvvrpYZB2rmga03gce07gSTm
         QBnrvZfpmKbkTvCcNtMrUo9X9/Ly/D4HvmmKgz700NVxAtqFsKcJ3JCOdaIS2yBVMmsF
         xRbOQX2yxJ/9g/kj4THfDBPPYFS56kpwmra2+T3iUUt6+Mc26OvC0e3kL/xrWN7cffWA
         BHyK49iKUYokEuqlMj1bELhhiggvkmhtgN0dHEogI1GaYOUa3I/ZAbCNbdvMT6K4mMgb
         EeskYcvFHx5L1beMfzED8Z1H6PwPDsJmy4yCEc9mrfqs4dvOfoPe4Oz+5l72+8vrbPBy
         ot6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596515; x=1756201315;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVLLl9OqNk7Zu3EPzfXMDRVe4XrWiVodoUaeSDsMNj8=;
        b=oUQrh8gYIQW9FViHlg0n3mXJ0eDlpgfdzxIPqJes8L9YhqE79oWdANNg2QpWhyDAVp
         JQ/W1hctNDLI8A6/NR289KCb3t7pfQxaDse3kR35eT0ZJVQ5V/84V91cWrLJJnnC0rdv
         hbVOLecII/WgkMc0ksQMfIEYeY6D+BYneHTCM6lUTGBPJPY5zAu0fVgQ8tAXpu56lMYg
         48tGROUxTxh4Koj/e6092Deyqb1Y8cH8yc4tfXWPjUs/aZ2wzx2SGy+SHSWcuRvSJY5n
         +nA+0IlGWShYYuFjDiJxJrYyP8WZIxOpTrRvTOIUJHH+Y8zUAXketaIl++PYQL7oAhDG
         W3fA==
X-Forwarded-Encrypted: i=1; AJvYcCWL67M/d/jizzzG3tTB2sW0M56YHED2cBTyFekQAM6uRZF1nBN3iQTaCCIi0et+zxkdjsdA7hUTpOZqkrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35lEtzBZrd8XpwyJBjWYFTlGo0YHpIDmbkn7QpKMpkGUdpeJX
	hsSC8+k5QMOi/Atq7lOmhDmAh7uKqK1ceX2RIbV2wPnqBu6CBy2P91k/fwFuCLbUR7Y=
X-Gm-Gg: ASbGncstRShkYOjiet6EK49SDljBAZn1IgzRPcjPH9f0y8YYErOEgv3XUEhYT9edQuT
	0otBWJ/jomKcwqydUpQs2kNTRaO6lxtiXyT0fDdNjGrvbser3z0YOuzzektlDh60deU74Z9yzJd
	clTrq9XvwCvr7lpczKn2/VD5ozK/WFs5VrRsDfuMZwR3Qr4c65BT5X3sOQlQe7JiQcJ4EW5HDnt
	z9roblJEwSEL/N9jnru26/eNYrf8oAmRtlPEUw6346pUmHs2XfFSrRYmRstNDhc5qhRJ/jdhZT5
	XFVw+xJuUUSZspan5yxXH8mY6Ybr1t8k2obqTz3fk8LHGVoYcy3jmTj55ZqBmM8lXuS7PATLxsf
	pkTGuYh07hUtiIlNzeFitALK5F1TLs4hiHL8oBMkvWc6EUoZNygmy7w==
X-Google-Smtp-Source: AGHT+IFmUB9GNTXpWwyDrW0I7+LgcmGoPg5Mmao/+q2ZsLIelBxWWUigl7kupDpLBula5DDMuHfjng==
X-Received: by 2002:a5d:5d0f:0:b0:3b7:8832:fdcc with SMTP id ffacd0b85a97d-3c0ecc3219emr1522505f8f.38.1755596514815;
        Tue, 19 Aug 2025 02:41:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077c5776fsm2929467f8f.61.2025.08.19.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:41:54 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:41:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ocfs2: remove unnecessary NULL check in ocfs2_grab_folios()
Message-ID: <aKRG39hyvDJcN2G7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that checking "folios" for NULL doesn't make sense
because it has already been dereferenced at this point.  Really passing a
NULL "folios" pointer to ocfs2_grab_folios() doesn't make sense, and
fortunately none of the callers do that.  Delete the unnecessary NULL
check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ocfs2/alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 821cb7874685..162711cc5b20 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6928,8 +6928,7 @@ static int ocfs2_grab_folios(struct inode *inode, loff_t start, loff_t end,
 
 out:
 	if (ret != 0) {
-		if (folios)
-			ocfs2_unlock_and_free_folios(folios, numfolios);
+		ocfs2_unlock_and_free_folios(folios, numfolios);
 		numfolios = 0;
 	}
 
-- 
2.47.2


