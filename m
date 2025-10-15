Return-Path: <linux-kernel+bounces-855039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AD6BE0025
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 186C74EB774
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653734BA42;
	Wed, 15 Oct 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzkIzk+E"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94292FF14D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551824; cv=none; b=u0wvIHLvbvlysHL0ZvW3zwrQ2R7QXWLB5BRcvzvrPku76ywDp44v5xiKHbllBOH/3D0MHTapFQhYOc9cecgO8sXoCk+5zTqJLiYt7jeA3zLcRO6vKhJiuQdBtXrVb9H9wUcbapFDghA51/24O7lCl7vFu0RfWe0eIlFdQBU5g78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551824; c=relaxed/simple;
	bh=Jq7eXp8fib1FIP6eeCceInS/a/aZXhfZhn0wG7S3u/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OYZEqMWhf+XVG5teppkTlClTOKp1lW+YpgT+9yiZBV65en2rNBNMcKlLiICSUKKSEnT1mP2bKz0+rXP/ar8lKAS9MaIIzZGmyNS58Y/jYt3Zs09YLt6nyVg/4UVI7p493Y5h8Uf+zhwDHzomYC1vKFIYFd4IUBadLNPZxOOPJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DzkIzk+E; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ec2211659so10642926a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760551820; x=1761156620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A7VWrlGpJstNEPnOR+6vF9r6jJA3jjpAi47oFTgwahw=;
        b=DzkIzk+E9963cOfDLUa44fVKBGTVBctH6SF+qeYVLGEmPuAdU3eS/401I36+32POL1
         FQIfZpmzBYffluVGnvNCW5nUFoQer3rlUUI5LfDaExkN1pf8qxoEZanjp3EeipqpzOrp
         EMWh7PzB18WkNElIYVvb9+dRj+uGcdDki1k3a2NAi1/ZFZ1Awvg1V2WjWSX+OfrNlZDc
         1ZWkPKdN4ainLvBZI9eldvxtsjWKDFdhx1hwe899U7JjLvuTCqXSbeivxjgYB1IZFviK
         P+dRQeZs/IVfibjDvF/bfBgW0Z4Ry6CPutDRepfg3MFDb9ZKQrzyWRByuSySkcEW0J2Z
         8w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760551820; x=1761156620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7VWrlGpJstNEPnOR+6vF9r6jJA3jjpAi47oFTgwahw=;
        b=YSLOgpcUHrlVAUI1XdD/a3hP/hq2gLj2zB/IcUYUVDpuqGBZckvejQrppXojIXRo39
         XbGy16AYmzmTnkz1DnuE3zF1ANTpx//vcW/5LKzXEUcz/P0lg53mu0o/j0V12VY1hR4A
         AoVSwEkEW6UdC5uXWGlOBGpIlET0Bh6e3eCexQkNonFwYP1pR3lyebc7YlPyCqDh7aJ9
         fJKlVs9Bs6Kit/qmXg7bvKg3CNm8Ow+klIbP3YQ7n4LxPDl8VrKmKXoW/sGYG+nSSRlf
         2lxO9fyHGiIyAlJjwNDcL5KHdmFkWkPeuKDOyo7KseQv7xSX+/2uyZZc45o74tbxfzXa
         TJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlAs8NwxFNLexhU30+U2lqsHsNgoLtnnOGcEPNjpoSbXMih775okxWaj5W/S+aMTJn6bUXXuJOgeGBHxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzls+mwVGMRnAccoDSuwdf1Tn2P27Z1rlqgL4JeqgKN/JvvlpKy
	17fMh1MJSmDpVBQSKUA8ePmtcnPFlKTo3ifmhTwagfmlBkBdbobAOeiZgleXWMd4U29ZEHf74LG
	u6wrRhw==
X-Google-Smtp-Source: AGHT+IFmybnsEOrIWbHshrhKc7Un8LMYT9HibOiZ3oGXQOVv28zVE4H0/7+CB4wu6CGtwBvzjybc6kehs9s=
X-Received: from pjbse5.prod.google.com ([2002:a17:90b:5185:b0:33b:51fe:1a88])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b81:b0:33b:6ef4:c904
 with SMTP id 98e67ed59e1d1-33b6ef4cbbcmr18963431a91.20.1760551819966; Wed, 15
 Oct 2025 11:10:19 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:02:58 -0700
In-Reply-To: <20250924145421.2046822-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924145421.2046822-1-xin@zytor.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <176055120017.1529012.10789026388840299534.b4-ty@google.com>
Subject: Re: [PATCH v1] KVM: nVMX: Use vcpu instead of vmx->vcpu when vcpu is available
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	"Xin Li (Intel)" <xin@zytor.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="utf-8"

On Wed, 24 Sep 2025 07:54:21 -0700, Xin Li (Intel) wrote:
> Prefer using vcpu directly when available, instead of accessing it
> through vmx->vcpu.

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: nVMX: Use vcpu instead of vmx->vcpu when vcpu is available
      https://github.com/kvm-x86/linux/commit/f505c7b16fbe

--
https://github.com/kvm-x86/linux/tree/next

