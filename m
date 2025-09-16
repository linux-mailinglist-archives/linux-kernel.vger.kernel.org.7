Return-Path: <linux-kernel+bounces-817952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43207B58972
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31F994E26D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0083822D4F9;
	Tue, 16 Sep 2025 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZyyk1Pp"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0722422B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982559; cv=none; b=NWhHd1C9XAHqg76fYpYZs12X2wKpN+IJpCfFh6lJVozWTwg2K+IKduORwPpUSQv5WA+06cPPhSPPdVEIiViPbBWbAlhfYEYqW8kepc/LOwYi5y4ZYISwpzpgQR83v/QjGDIP9xNx7xce+RdIkx6rtLd6MLMQzg8TOrx1xVqwfdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982559; c=relaxed/simple;
	bh=2wOnBKKCaFqNYjyYc1v49OMoQyv2y72DCIFRe5yU+wc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p7VoZuXH41ihgsTPfzNTbH45hjl3oUh1n6sb5In819R3McyZdI7JEum8o/6WZ0SpJqejDzBMttYoXT8SPnSssn/GVaVlRZdrgv4uB1Z5faQmPEhJ7V4YYBXzw2w5+Coghnr0wexd4Q1RR+Ysy061KU+FGcXpdkc3PpgPaKuQrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZyyk1Pp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77618a8212cso3107342b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982557; x=1758587357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncvI8QqpwL/ZLQ3Rb9ROAQpWcIVFT5sOJk27qsYiqbQ=;
        b=HZyyk1Pp0fzQQFhPR65T0OOEvU5Nr6Akj3u6rFzcIg/zviamSRMZO639CDTZI1GuKK
         TExUvqFZJG0p1keRzpQKnYT4zbhE28odMoCLycgDnIpTs1L8x5rV9uR9xdFX5ZTdfNTw
         7RAF6ZiV3Vh9ZQ2T4qLarkJHWQSIoZA0fFJFiwPEe4VqjsDhCaHzLHYJVKPJweIHqnJ1
         BixfdYHdpHk+qRpyZ5rndkTVUdu9LxlhkRqpXutVFXSkowJm3Xp+ddgLK77FZQjdTte7
         o/+z4baZVPhA+qAliT2ndfm06s6v3zwsWEOmwV7p3q3R/yyH0sV6m/O+nLWMSkes2QwP
         xodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982557; x=1758587357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncvI8QqpwL/ZLQ3Rb9ROAQpWcIVFT5sOJk27qsYiqbQ=;
        b=a/B0ozsI3cxLPvJ2ODrhYludVdVk5XRT1TfYJ7ZnPawOA0CsM+SWZDfq3pyDOZJQJ6
         qqsqYCO1lwKZpJHb9CV6k1+qO3Ni5P8zySdk8ow3eSqpugCc7saauNenckXmzn7r/nvG
         5H959lA6UfTHez8G95m37sdwxYbzye0k2qiLSQx+ioaSQob63zpinKuBSkGGyCc7Kh92
         evJoboKENKBmUi79HMYPk8XvWf8lEBf70U0v0EuXIi+daeiyYquqkhQFnz083KRG23oz
         WcmRt0SLb9NLgje7gC0D6B7sm2iVi0+M6VKObsyJjMx9rQYLF2OlICCUGcmk0rDWkACc
         leeA==
X-Forwarded-Encrypted: i=1; AJvYcCWXnTOc3WCySclQdcng8t5oGkkX3NtDshEIj8EW+NYqzC2NxcCORd3QyD4EDDJwVPQexG/ua+h+F7GyR10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfDcDfSP+51MsjgZKhEKu6GMeFoMj2jTYr0HH1KGoqswJT/Ox
	1ucC8NgR4PRQJJdREhYyA/W8uRY62W73oVTLo5Ywmn4SSdtlw5h1xPUqlIP9K588DPKeifXz/qL
	p1mPHNA==
X-Google-Smtp-Source: AGHT+IHkRT4DqkkQPQ6Wz5aWthlvDZ9K4ii4O1nKvY9tLx3KTJzRJCPn4VDALnbl5lqF54kV9tqqjrI/mfE=
X-Received: from pgcs188.prod.google.com ([2002:a63:77c5:0:b0:b4c:5356:a130])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e083:b0:240:1e4a:64cc
 with SMTP id adf61e73a8af0-266e19e33bcmr585198637.12.1757982557184; Mon, 15
 Sep 2025 17:29:17 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:55 -0700
In-Reply-To: <20250821213841.3462339-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821213841.3462339-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798183763.622105.13979061125365252819.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SEV: Save the SEV policy if and only if LAUNCH_START succeeds
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kim Phillips <kim.phillips@amd.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 21 Aug 2025 14:38:41 -0700, Sean Christopherson wrote:
> Wait until LAUNCH_START fully succeeds to set a VM's SEV/SNP policy so
> that KVM doesn't keep a potentially stale policy.  In practice, the issue
> is benign as the policy is only used to detect if the VMSA can be
> decrypted, and the VMSA only needs to be decrypted if LAUNCH_UPDATE and
> thus LAUNCH_START succeeded.
> 
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SEV: Save the SEV policy if and only if LAUNCH_START succeeds
      https://github.com/kvm-x86/linux/commit/2f5f8fb9de09

--
https://github.com/kvm-x86/linux/tree/next

