Return-Path: <linux-kernel+bounces-799147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5495B427AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D05E121D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C931CA6B;
	Wed,  3 Sep 2025 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYvbkxm5"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6443223DDA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919560; cv=none; b=kRuqNtEwrhSDZpvIOImXYFuQzv0Qkvw+gAHH3/SbszXov8l32ouRPOEgDmzRFX2Qh6Zx3bQ/+inHq85dMVavlkZEBiDKc5WDg3iAmGsG2HtICC+BumIfO9x19G3OgklGiAZDCVSO0smksIvh/vdJmJrhmoX5ukk0VC3HGyHN2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919560; c=relaxed/simple;
	bh=2X4fHau38nZCsSppyB32TjN0Kbr1JddLB7QgEx1atP0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IO2m4+/3aba2M8Vm0g/NhSaKVU1TIjwkYwhWIsz6S2vPIcsISZf67jTSGfbUzo6weggZNany8/Fydb+n8prSKglR12VN9jlqy8sBBDXG1dD1HMC82rL6vX/9UQoV0Ln/rpjur2byBVgdm/66ry5czr5mmMs6UYqPuK8tO7OfPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYvbkxm5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7722bcb989aso126839b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756919558; x=1757524358; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8UN6aAk86XHfi1AqzsoZ1Ie0WQEmU+g0aktuhkIbmg=;
        b=iYvbkxm5Kd4LjrKIZ6uQyRBbr/6bRbknHbSTBsK3NtlEtVpCz4bVwE7L3yMbamucWy
         FTEPZ8vhvyW6dGu4puMICUENhI5YT3tnpCXI0YiJcIUvHMSmgtNITqhLG0PzlKDrDMEw
         abaTjhNimtzVdsb0M8M80Yrkc4jK5MqPr+lrkifwRD4OQek9qd0bqlikuO4GT+3/9CLn
         BSrqEf+WqwXXfN+JKDiTrJlGKSm8kRUu+0CyaoEjDynFf+LLwYxX5paXBI1z7WPeWiOL
         pkw9zyuiZzR0n55qjHzone9RN/ky1uFj2WKB64NitM3gd6hOqwQAzFWaxcmxH10ogxyQ
         uiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919558; x=1757524358;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8UN6aAk86XHfi1AqzsoZ1Ie0WQEmU+g0aktuhkIbmg=;
        b=UZnPjL4fQ+99F2rCHNR9IfnZHzOF1jNZRetXfaJwL7GRmrxiBZUJWS1RvuEAwLBrZY
         kxhERRuN1VLWu/1lN9tSxDbxVKZfQfz+a7Etqkdv1DVDi/djPFbQ/iSOzd5jomV+rIdI
         OAblnpfGZL4Sj5BUm9VFIeUAY6Om/qkUEs/Es/jRcKakeEblK+8tkE68D0hzeBRaveA8
         zfQNFfQ/pS02sG9U0O2GurKaMDPEwwMtJgn23pE7JKlLbye/CWLvsPyi6e19JZhR0IhE
         8k9apK7tSpeYXick5llgoX+dCHpW7Wu/0Ftecule7zyl4mh6wDRXVCuknJdpIGaaqUU6
         gHNw==
X-Forwarded-Encrypted: i=1; AJvYcCV5IBV50s48IXgj7ZVMkLw81Ykc5RVaMUsDoVyhm6FBrbPsWTXR9v/FDKv1E4LLCS53TV3qK1mXfeDUe/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSUk9fOk5WG5QVcU7TcD8sELUi8Mxu5TOq4/yi2VDGMv4yMr1
	OgmyrFCePstOWPAr74R+ujvvqlCUmJy3rd/amiJek4V5Zai2seiy2+v7XnXBHw==
X-Gm-Gg: ASbGncsnMvg/keX3VVLlvPcB9/FG9WdW3xyoa5BIFS7KATotEDrwFaeJ4ygdwsseunu
	7svCBqR9RxyzT9socLoeMvQVe3kbBtmKX+bqOEJnUCAZ2y+abMhC3/zPT1yVrWtMyOyvVGfEz2x
	q6isM4rY818+qUT3RhR+kOWxwAYpeBUN4kUnN6VfXDLCJNCjurCsdUKsqfum0Jpj1orIwGy2Rhq
	b9WcPtwDTQq2moMmaOthuI5p8XSQ9FhFfhY7z6ONBI2EIMGQFnJfo6iLoBhX2OJAidNptFfoEpH
	l2FW834Ud9nlkBnJT1TVUJYffmDV2qt4+V25vrn9hFl0iG7Crdi8n9u74c93cXAjwzu+/X/0cZz
	ogUHWl+x0PIgkMmvRvP/+XbMSG1goFHnQ
X-Google-Smtp-Source: AGHT+IHXhaNW+y3rdGj0LdoDfCvN5S41f6AeESlguNEOsXksmPDQ/q5mjC+Q1qMvBr/KVZYyjqFgzA==
X-Received: by 2002:a17:902:e882:b0:243:e3:a4e5 with SMTP id d9443c01a7336-24944b51fd5mr236666105ad.48.1756919557690;
        Wed, 03 Sep 2025 10:12:37 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2af911sm16889931b3a.23.2025.09.03.10.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:12:37 -0700 (PDT)
Date: Wed, 3 Sep 2025 13:12:35 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bitmap fix for 6.17-rc5
Message-ID: <aLh2-4qZe92l7TwX@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the NULL dereference fix for sched_numa_find_nth_cpu().

Thanks,
Yury

The following changes since commit e6b9dce0aeeb91dfc0974ab87f02454e24566182:

  Merge tag 'sound-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2025-09-02 13:38:07 -0700)

are available in the Git repository at:

  https://github.com/norov/linux.git tags/bitmap-for-6.17-rc5

for you to fetch changes up to 5ebf512f335053a42482ebff91e46c6dc156bf8c:

  sched: Fix sched_numa_find_nth_cpu() if mask offline (2025-09-03 12:20:06 -0400)

----------------------------------------------------------------
bitmap-for-6.17-rc5

sched_numa_find_nth_cpu() uses a bsearch to look for the 'closest'
CPU in sched_domains_numa_masks and given cpus mask. However they
might not intersect if all CPUs in the cpus mask are offline. bsearch
will return NULL in that case, bail out instead of dereferencing a
bogus pointer.

----------------------------------------------------------------
Christian Loehle (1):
      sched: Fix sched_numa_find_nth_cpu() if mask offline

 kernel/sched/topology.c | 2 ++
 1 file changed, 2 insertions(+)


