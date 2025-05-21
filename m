Return-Path: <linux-kernel+bounces-656749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB752ABEA78
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 05:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201AE3B5123
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 03:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0F21147B;
	Wed, 21 May 2025 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KXhLhxjG"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CDA7081C
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747798489; cv=none; b=DbbuT4XcepPnRPwV8W/UycXtKUx4LM5afaoJHdFM16VzyE6hBd4Ws5a1VUfjdsCbOtc/74MQAKFNC/rPkfFslm/7aUbuuSnkutS3+CdV8RlhNZpkK0jEWIT1DPSk61mb7p46bPxYtMeG94QGvG92buraAaoTML2Bt5k9YRnj+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747798489; c=relaxed/simple;
	bh=Zk66fyEM2zx49X5y0UFZoranSZ+jdhIWtz5HJh7HXr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li+Ss35uGCtoOwp+QeOw7v080xlE5IrZZNen4c7XSJA2uLEaxEk3kU/ifE2V1q5JDKFTFgOrf5Dk7SMZisV2DVB2IDYYvcvpZOkbgDQ+lZ/D8o9kgqDahYcra2pP1ocdpPAoyexSMeuQqbUfArfZTu5VJk9Mqlt1zbEGEGYN0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KXhLhxjG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso5995267b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 20:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747798487; x=1748403287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrF20aYmOuDjKY3rsnSXTn3j3mYCZ/2UIOF9yf2b/qU=;
        b=KXhLhxjG6MvuKO6HUXN+WOnBBAp4V6OaGCdpG/iDobBMJLqnVjQN3tY7L3ojtKQ/yy
         wsWDHW2HCM6Q+JQqW5DqpTx8fKIA7oRDIFPS6HZW/NF+ozRZtpdmv9ALTBInhsIi9xdR
         wqR2qbW5R+G14XsgmLrrqHhw4P0cTe7xXwqD0ftNq8/ducJbiSe71UI26WC9gkxJ46xY
         PzV4wysT+1si6XRnGr8kjIsTBukbrdiW7SDfv8Fg7r1+YTttSQUXJzRFFjgK4p/Nk7+B
         PH5tpwbSN7QOJ9ZLcAqYRIYWTOOXEkeNeRzve+hoWzpb2s+ZIV+ohCRegg3PXPlrbo4e
         VT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747798487; x=1748403287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrF20aYmOuDjKY3rsnSXTn3j3mYCZ/2UIOF9yf2b/qU=;
        b=xBT84SWW64gxdqKTcw6lH3aoOTy8yPhJkmdaNpANMBQlQ5xSjkF39+7VfdBrvpzWSX
         1N2UG/kiVITSqyV5M9pi25Pj++rDAv2jzdJ35QU3bnC326OK/YsPjeNZsMBeawEFqUFc
         EzGUjP3FEFz9XtBwT0wWgWDno1xLXWSGHcIZ0kVxylLkzYCCuchZJcPfxUAtAtl2B5vp
         2jm9D7+wEsfrOjCiZO55W8L4sWCJ5yU4eMP/TYVSBeT2QV7AyhqcrPswKE08AXetBv77
         Qu1OfPzuaZZ/WvU/1Drdq4cyloEYi4BtuTiZNCjrvqz4jLf/8u7FFr5v5ZgqED4qg3Ox
         t53Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc3Ht4Z/581jAedaxmD0ibCjesJhM0FM0Z/gBEGv3Ddmclgy11iSfjVHvaEZrtOXNEW3qdNlHW4JR0TOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFeHs0tFBmzEws67gX3BYm+RvUssxAdoZo8nlm2iIo9VjMFVYv
	2PikoiYZ/Dnje9A00q9SRSoGlHOpegOaF/MxGWysNPB6GBVZHDT1jE6o0l2Ih9RXEJg=
X-Gm-Gg: ASbGnctbjNCpzdgUPmBzTFz+7lm0pUb/lIpxhvY2eq4SWukL4RJdMDdoNMm/lzsGYYW
	2/k6sjunvwY27Y8zijyXY+U9Z1jVFO/4tbDRV7Og7cCh/UgR7xsOkeYwYQILKAKNBrY44evYjBu
	CeORAII/4fgPT0dhvfp4a7Emwr2OCONteMFL6aRXb6f4QtgnPAzFcgsKYJXSSNmyxoQHTD/rs/R
	vwi3QiSH9jkRKxGNkO2FxtqUKL6r42gJ12CJDmE1RpTs7WNy0lBTpiyxpKy0EQLzKX5o39zjeLh
	6JgJYZsrL8ZODbRcHjikk+xvR4lY54Km2eWiItyLTziGWqdmGiL65OumQfTRsGLDcO/D66skEJ2
	DGEE=
X-Google-Smtp-Source: AGHT+IE0BDXpgbrb6T16TX0bUZrcxSHGXSW4xi9rTQEqrY/nzVnAq9tlVCT/3bjK+FISbu389N58cw==
X-Received: by 2002:a05:6a00:858f:b0:73e:1566:5960 with SMTP id d2e1a72fcca58-742acd507c1mr24045768b3a.19.1747798487243;
        Tue, 20 May 2025 20:34:47 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9709293sm8604835b3a.37.2025.05.20.20.34.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 May 2025 20:34:46 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com
Cc: david@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lizhe.67@bytedance.com,
	muchun.song@linux.dev,
	peterx@redhat.com
Subject: Re: [PATCH v3] vfio/type1: optimize vfio_pin_pages_remote() for huge folio
Date: Wed, 21 May 2025 11:34:40 +0800
Message-ID: <20250521033440.72577-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250520080719.2862017e.alex.williamson@redhat.com>
References: <20250520080719.2862017e.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 May 2025 08:07:19 -0600, alex.williamson@redhat.com wrote:

>> Before this patch:
>> funcgraph_entry:      # 33813.703 us |  vfio_pin_map_dma();
>> 
>> After this patch:
>> funcgraph_entry:      # 15635.055 us |  vfio_pin_map_dma();
>
>It looks like we're using the same numbers since the initial
>implementation, have these results changed?

Before the release of each version of the patch, I have conducted
performance test, and the results have consistently been in
close proximity to this value. Consequently, I decided there was
no need to update. I will include the latest test results in the
next version.

>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>
>Appreciate the credit, this should probably be Co-developed-by: though.
>In general a sign-off is something that needs to be explicitly given.

Thank you for the reminder. I will correct this error in the next
version.

>> +			/*
>> +			 * Note: The current nr_pages does not achieve the optimal
>> +			 * performance in scenarios where folio_nr_pages() exceeds
>> +			 * batch->capacity. It is anticipated that future enhancements
>> +			 * will address this limitation.
>> +			 */
>> +			nr_pages = min((long)batch->size, folio_nr_pages(folio) -
>> +						folio_page_idx(folio, batch->pages[batch->offset]));
>
>We should use min_t() here, otherwise it looks good to me.

Thank you once again for your review! I will correct this error in
the next version.

By the way, using min_t() also resolved the build error
reported by the kernel test robot[1].

[1]: https://lore.kernel.org/all/202505210701.WY7sKXwU-lkp@intel.com/

Thanks,
Zhe

