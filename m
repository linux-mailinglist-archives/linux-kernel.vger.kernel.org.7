Return-Path: <linux-kernel+bounces-828853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE8B95A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E849E4E2D41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50ED322543;
	Tue, 23 Sep 2025 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWRWMGcJ"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD46321F3A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626775; cv=none; b=glL/7YOF/q3cp9OyTH2PCFlDApoSvZF7Ft9gPtHWflKu3TK2A11W4uaeGOXQMOZDAqRwUB/RWodIvjmr0jrOan5aJXRPNe4HRrPrdZeFBmgsgX6RMqeVhUY5iTm6aaYwKkUHcJXJGKrPuDtb20hdWsUQPb9TAcVKTe1co5n3l4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626775; c=relaxed/simple;
	bh=vAGOBaNyo7UBOtDtuQKzE88y7AhGcv1FK06g/C72pIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fYptdT9AKbbSQAv3lHw9aPbDhdXQegGgbaVz6G2aIkg7mHMbEtDh+If3LfreHOO/syxIOUEcf5x5wLGGGVGUSVV2AP4DfTFx8gF9MqXXfAUtiVeJFDuP1Z6I82mKpLpjhzjx49M9Ee4jrJ6U/F/dT5Geez/tGiqyyGLvJy23yok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWRWMGcJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3071544f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626771; x=1759231571; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ofwUTrC3ZszDdeYuviFmsB1NEgkEhNxkFdaO7tJEVQ=;
        b=DWRWMGcJsaAgz2NXqLCWHYsnEhhvzIYGuHDphNOrMSqfa2Ijw3vvCuos2AyaH6oOFZ
         8/PGdGv+EpiNR2Tjh0MWXaVLwMv2D3eg+Whyj6xPIZR++4TjyQm+1FjCVBdyJIn32HQF
         oif89Y+tfDqwVddtpzV3Dps9jY6/eepcUhDVXgPcOwvzNWqG7rdWX28T4uJUR2F1mJc8
         mkBjAti77skXaScbv2Jh2dIZZR0BxcICLhL7WW3ABuOK6FTMatl+J3qgoGD2B9ZsEK0J
         +nD03Erzjv8LUC2JMFD9an8++nVVH+arunqdEMBXzO5AtR881EhJTp6XGQxV/jOLbpF5
         fOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626771; x=1759231571;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ofwUTrC3ZszDdeYuviFmsB1NEgkEhNxkFdaO7tJEVQ=;
        b=T6/1ApqHOkFcZyN9vw8iRp2MUz6sC4eld8n6mqXr6dImopaMA7ELbSnktJPeUDqymB
         s9XmyOuzKJbYVzQws8DSzqiDOT/HlYA9pUKkWzUCYbyTjORrPAUMi2i3gOVuOFKmaBHj
         NpP/huHXRQq6f4JyovjJLWhq6KLIeCqWTyoI2BXCf/0DmwCeFOdlcHoMBYQ/7FhKGIkB
         UkqprNvxhPgxuOAv1PjBLzynCf49wW+b0LKQJedfvtzFOWWsJn22lK8XIzx2W4YRLxxd
         r3bI1S1gLMg1i3RwDyxOyHFRbjF+f/nwdd6GMKXrbYTKpj4SH1yLOzn7KVZKpbrj6DWI
         tiIg==
X-Forwarded-Encrypted: i=1; AJvYcCVd8J1Efgi4jXB4WiwaX6Zubhdtz4rq4qVCDkYaOmYo/Rx+svn6YAYR6CqF/ASow4hFCWxKu52pAwa86dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyBOh3xGOV3ovhj1AvAwXSyZJmvJ6FSdTD6e+c0cOqk0x2zr9
	3yQmPSUNOLkxiEJcGZ2At0e2EV3qEOQoifMYB+6+p+xVYdUhkE9AIzVC5qo0a7WM7pI=
X-Gm-Gg: ASbGnctl/1MdxZgKHiZvooYZErcxAZPhF8bEuGma6vfpWprRv0+/iJdpEr6ZHRscV1V
	wkd5ZAu5m66Ta4JzsZ+j1D+l0YxywY6xInsW03Okhjq/utxjrxU5zleiersJpoBGMaIGBgXzwM+
	huyqKfjxQQTMhcfP1BtAmx0vrQUpk9SLbygv/PMF0f5oAWNpA8kz1hqnvLXaATOi80vWXNEb5b5
	QF8dPpkKh/63M5/TTXpKMsBS1so1yjRNIPBW5R5zlTRXaKvgZa7ES1o4EbunSd0R8wc5EsMmyD+
	aROltxU2n6fPVRdAlz2B3XdMSzRdxNnZutUA02lF2geIzNejZ8ivYVFyGH2YIN9VlTjSBQjHYbl
	ISCL+FHCTeeA7sY+OEfaXI0KRBLzL
X-Google-Smtp-Source: AGHT+IHhOwn6gj+iEexXiGCoorzJAw/kGenVZRN6xxRPh7vGWAqPpdg4EL4KLpicEj1CiwOETeW/FQ==
X-Received: by 2002:a05:6000:1aca:b0:3ec:dd16:fc16 with SMTP id ffacd0b85a97d-405ca39d48bmr1912334f8f.43.1758626771359;
        Tue, 23 Sep 2025 04:26:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f64ad1b0sm271511895e9.21.2025.09.23.04.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:26:10 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:26:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ocfs2: fix double free in user_cluster_connect()
Message-ID: <aNKDz_7JF7aycZ0k@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The user_cluster_disconnect() function frees "conn->cc_private" which is
"lc" but then the error handling frees "lc" a second time.  Set "lc" to
NULL on this path to avoid a double free.

Fixes: c994c2ebdbbc ("ocfs2: use the new DLM operation callbacks while requesting new lockspace")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ocfs2/stack_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 765105f1ff8a..be0a5758bd40 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -1011,6 +1011,7 @@ static int user_cluster_connect(struct ocfs2_cluster_connection *conn)
 			printk(KERN_ERR "ocfs2: Could not determine"
 					" locking version\n");
 			user_cluster_disconnect(conn);
+			lc = NULL;
 			goto out;
 		}
 		wait_event(lc->oc_wait, (atomic_read(&lc->oc_this_node) > 0));
-- 
2.51.0


