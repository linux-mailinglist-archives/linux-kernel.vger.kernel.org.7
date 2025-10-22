Return-Path: <linux-kernel+bounces-865042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69266BFC12D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5E9A565501
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80BB34320D;
	Wed, 22 Oct 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="EMT3FnbT"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E363451C8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138124; cv=none; b=rxGU/M8kYH9uDk8pOqbZJoOQhkswANjdSmVYkRSIDLNolbqf8E9nqWkyxI096CEcSRJanaemxNF59CwMcnVd1E88e2vXrb94ebbzHrQDh0DFa+fieWXyDo/D+fHILWNhf8DmTm0Djtpu+pzXL6BKcyswWiLK23xJTNXvZDeanXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138124; c=relaxed/simple;
	bh=YyOT6xckVX0MriiIl7HBo2d4T8KTUI4Zs0unfYBtZTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9HOi9HMqUTP9x4t9xuyWbZ9i3jTtGN2vZptwc+ltigxUlGCN3Xwsfw5LNvj7PGLCrmG0+I0CwLWKxd0Z5etmFaCxIiHkNYR4VjBGrr7JKwgHOGKEYmiUcN0uwV2rJdUjnUdZ0+7a11SFfllKS9l5DqyUupPdStTBumOWG3mz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=EMT3FnbT; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e1c0fd7ddso5120445d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1761138122; x=1761742922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YyOT6xckVX0MriiIl7HBo2d4T8KTUI4Zs0unfYBtZTE=;
        b=EMT3FnbTWISnp8qFS8tmeCFyrvbxL4ZJ3ydv8XGpLrnSQyGWnNTULQQ1Y4/Uv7YtmJ
         aejyuE/km3ZFPTNKjgN35GzsNqohMByj2wC3QhKxYd4BTwyYnzO8/PimtHyP4DWyoUmC
         HbQmXuGB7ijOqy+DW0+cnwrvuyAPzXLvEEvWLH3YlMN5N7hXu1htCCv0Ju4buO0PQYca
         BKJLZkFB2wj5fDbS8BIdY5l1/ZZC28uY8WFgIbJAQD/y9gzBsEBc9kAXHAh24JO4okOD
         wdm2j6AkVXrjr920Hq9FSNCStvE9MVB6Q6rWrwny4fxWx8knVoz6lCNVeNEuUjL+jY9z
         7kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138122; x=1761742922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyOT6xckVX0MriiIl7HBo2d4T8KTUI4Zs0unfYBtZTE=;
        b=iEzuGdhjnkFmGcBJ7Y9gljHt3lBtOnEeCNbNOFiZxn/+0p9foJT0Coqc+G/HkoRGp1
         wIN5rApMr8XjVuCvelDgnfpaGOKsyBNkc8TNiIlEii+6uX2rEHKIbRtBDou1JcvX3Otp
         NQecDrp3HWD9mwPI5LDArJmbmf5nVth33hEtzkck1uUWzDSAWynv9akiNN3aBau5oqVR
         wSWzJ0oeyXrrGsg+x8FBtivoHOnej680lu1V5wPLlcoep4y2DCyTdt5ZU2BLwXW2b+eF
         bYO5tn3/Z5i6/UhmNPKQAsjLVhZemJRLDL2E03wNu20lkK8Wj11psNWdhuN0nauLt6P6
         xzkA==
X-Forwarded-Encrypted: i=1; AJvYcCWS5BAQinFWF/qVLwezcXvcTqRR4/Tt26F9u9WeMiJpCSxGRIdPByueNs94nIEHXkQAYUAZCwQ8/ZS+HtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCmqJgWLgj+dEqC+YgwZCjD5WtfI3Mycxr8TFBO0WiYecNzqC
	aDfiBGEX9FunZRhC6Egax6MFk0GhErdH0nrYRBosLq6DnwqZnesYDpukFsbiOIJBlNbwXxMBxPR
	7Vi0RsHA+YTiurT//ib+NZ11FqdDpi5DtyNiwBwLyhxlfX03DlvMCelgBng==
X-Gm-Gg: ASbGncs/f1GDOLbmkamQ695dpqCoClpja/avbkYUPY+ASYIcEGZFjpEon9yrepZjEqT
	NeDCHOCTOzxUzcEyanHgiDLwtNzStNAPtfSlR9Y8zrOTc/G0IIgKr7r2mIFHzty2CF1r0I9HZio
	Btmx+77aqnwY8UZJYlVZjeH5Ntb4NDO8QhUZ5dvNbwJ9YukfXdAeXRILrFYzsNai6tonAYthqVl
	pZ+Cbm97uCvW+2fKeFhdAKYU4Ucr6Nw5Mbq/YCuYAGK2W2nn4579hPVrd2U/qTJbdbbtvKf
X-Google-Smtp-Source: AGHT+IF9jG7efkMJkLjrKK96cUycd0uKP1eoJk4jV4LE5zYD+KPHywlzQYSMFmQ/paz3aQtOfKK1rFQpJc1+j+AphxY=
X-Received: by 2002:a05:690e:4182:b0:63e:d1f:d683 with SMTP id
 956f58d0204a3-63e161c551amr14636102d50.45.1761138121557; Wed, 22 Oct 2025
 06:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021133918.500380-1-a.melnychenko@vyos.io>
 <20251021133918.500380-2-a.melnychenko@vyos.io> <aPeZ_4bano8JJigk@strlen.de>
 <aPghQ2-QVkeNgib1@calendula> <aPi8h_Ervgips4X4@strlen.de>
In-Reply-To: <aPi8h_Ervgips4X4@strlen.de>
From: Andrii Melnychenko <a.melnychenko@vyos.io>
Date: Wed, 22 Oct 2025 15:01:50 +0200
X-Gm-Features: AS18NWCJ-LY11lV6XRcH3jguswzoDQqltcrK4QfPMuRXpo5tSQWNpGqcBGGDgzU
Message-ID: <CANhDHd_iPWgSuxi-6EVWE2HVbFUKqfuGoo-p_vcZgNst=RSqCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nft_ct: Added nfct_seqadj_ext_add() for NAT'ed conntrack.
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

> BTW, this fixes DNAT case, but SNAT case is still broken because flag
> is set at a later stage, right?

I've checked SNAT with the "PORT" FTP command - didn't reproduce the bug.
I assume that `nft_nat_eval()` -> `nf_nat_setup_info()` sets up seqadj
for the SNAT case.

