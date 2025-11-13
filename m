Return-Path: <linux-kernel+bounces-899243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B319DC572A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D8F234ED10
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4C33BBA4;
	Thu, 13 Nov 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OkEq++gD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BCC2E3AF1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033088; cv=none; b=jhvQXcp2yDx+FfY44Weiq0d46tUpeKAlcN4JUJINZo2oWwwEp7JmvqZt60jj9CqNG0l2MAri3PbmVXvhDJc9yfUf6wRw8ouc8fLHi9KFCPer4RxsEr1GMb2VFfQuLD+3nFeZAHg/9H3DaYL/siufyWk3FYMSKzF6vT1XXVzqTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033088; c=relaxed/simple;
	bh=PSPeh3wIcHSK2lCrRAT8IVLYiPh8UFuCtOYhIQ7zdLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcNL65XY68DUVBGWJDNtjltVG4OtlnmwXtxeXjcYXRpbxk6KtA/OcB5SIhQ4RShre6gylA/Yz/IsLKDDHLopp6yG8Le4G8DO7rBdGSsvxAxJvntDVWoBQM9miEMjwm8bkxFfNQvm0Ia9r7NiI6B2ygrqXllOzoiUb1LWCyme+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OkEq++gD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c82bf86bso399838f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763033085; x=1763637885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ShGcGGjDK9hCzjBRmmgiQv/i+2mv2XlZVsZhuFOFv9s=;
        b=OkEq++gD8TwQIONHqhKqkYHXPP9CqnUl6/OVV4qpYXuz+yhdTBr4oA+f7SF4/MleQw
         /CJ/RvGxVkLHn0ZGa0IPW+CbhNNDWdDi80tJStoDI0M+3qEUoqVZ+Uw/SF8G/mciXeTN
         ob3UcxlVwVz67kB3rZVAEgvci7Mt/6dcEJNeciWIWuZReFARmwD/n2gOlR+YtTlWtOq9
         l+70HdN+fqACE7I8ndBOZiK2nWAoTkGnMhsHCELLi3e1bJalsZqLZoJ27NDBTs4Aq/Ta
         oMha3YEV7g8bqmLrdp05qSqdHdwWSwgpoJixPR7duav41/aNXvgeFxk66kLQ4tDrAtpz
         1YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763033085; x=1763637885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShGcGGjDK9hCzjBRmmgiQv/i+2mv2XlZVsZhuFOFv9s=;
        b=AYiCcchn7/lfpP4w9AKX0GGsmyl9P6GTZ/1+SojegiIOmL7f7u+Usr41oD79NT4tpM
         eHs9As5e4wDUs2H/5bHjcTX6jpCucJG7DrkF0mw9aAgec7Fo8/dqDkrhWbzF1wXz+q69
         Aldz6UHjuwYYDvUpivIQrfnf2CNijvvXGlsgul7ji5GWlV65sYuMRbVB5+WUcQHp5mp9
         MkPPZye9k8OZyFjXCk0JmfS5qKQOX0EPZEAmCDRD1cyl31Nu1votZ0WXziDttF6Yk13Z
         kNUzMym6OISoI8eq0BdUJZvnmLBiVlyfySIJKFO60juQiymwMvZjmYaQBi5Y6CHR8Nai
         Xu2w==
X-Forwarded-Encrypted: i=1; AJvYcCUB5csYbd5WeRng37M0n+5+97OFTNu7zXH3fpH0I4DVNF2DZG1FlFOsSZFcG/5Dkw9WFT7ldd+KbAOqiP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTraEviGKYvZ31oK80MlBE6DrtECX/L+e3NWoBso4EE0UHBG7
	g+7EbuaBFmwneKBJKZV3TrqJJ2A92Py094udOmRCfL6PqpKiYhLFQxz+L9j3f+ChnKKL4J5w5LU
	xUNH+RTP6t+F9/A590dpap/QjhpV/XNm6McEU4YJistaot1TsCc5l9u4=
X-Gm-Gg: ASbGncvWVLJhZsoCLET8ezXtAHM75cQDCi2FYsDmB8wDsa/+q+9woSPNbf2DCFnuueW
	FuLXQ+yVEqnFXWCNkpKC8QCgsc/GKnPF9my9H4fv4EORftnApxmhYe7J0iT0vqKsHAfAlMgZMCw
	rm6dYQaf8GVWhUUmEuZlqfTzB3wmcIB2oMdYOI2yAOaJB2ETR2mPnEJWJtnQUe+++mTLv5/oj50
	u5FAW8djAnyTmid1u7j/7lOIMKK0TUGG400Rp0lLmRU+0XY9U06K7ibx+RxQj2VtKx+vUmgmWsO
	T0C47/hVIYDbL6XMNFzaEnFOwENrNZn90kWWGfgrg+f/cYBYD8lc+C5WzA==
X-Google-Smtp-Source: AGHT+IHtVYz4LqadYZlp+1/zWjmgNJwOOQpfT1yxfPxnbAKTCR7N/JuFC3EKr9Al+1qLKBr7Y1H+obuI4feFMMBooGU=
X-Received: by 2002:a05:6000:2509:b0:3fb:aca3:d5d9 with SMTP id
 ffacd0b85a97d-42b4bb8ed31mr5500146f8f.1.1763033084756; Thu, 13 Nov 2025
 03:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251112193611.2536093-9-neelx@suse.com>
 <20251113103222.GL13846@twin.jikos.cz>
In-Reply-To: <20251113103222.GL13846@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 13 Nov 2025 12:24:33 +0100
X-Gm-Features: AWmQ_bnfQFUVW-y-RmFk3GZ2Vr1w_xjlhKecERK9P0qT8l38FW-u28yL9A5nmCo
Message-ID: <CAPjX3FcKLCB877RZr=NdGK62i01ufGJvfJzGQ-v2+i-kfzEnBg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] btrfs: set the appropriate free space settings in reconfigure
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 11:32, David Sterba <dsterba@suse.cz> wrote:
> On Wed, Nov 12, 2025 at 08:36:08PM +0100, Daniel Vacek wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > btrfs/330 uncovered a problem where we were accidentally turning off the
> > free space tree when we do the transition from ro->rw.  This happens
> > because we don't update
>
> Missing text.

Hmm, this patch is new to v5. It doesn't even look encryption related.
I have no idea what Josef really means here.

The whole idea seems to be to call
btrfs_set_free_space_cache_settings() from btrfs_reconfigure() and to
update the ctx->mount_opt instead of fs_info->mount_opt while
remounting.

And btrfs/330 is not failing even with the full patchset applied
without this patch. I'm wondering if it is still needed after those
years?

