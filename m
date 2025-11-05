Return-Path: <linux-kernel+bounces-886840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C853C36B15
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105506402D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4355321448;
	Wed,  5 Nov 2025 16:04:48 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122A320CB6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358688; cv=none; b=BrolHl9SOW1DL84KboKSmYBAZpZkyCI8cB5kLhjVhsDhi1T2GzIytY0Z8IJIqK9zaKjrb9IoOy7PLwgQekjg0RW2z6EpY311ieM5hzF4TRi/nLFaf9NVwkgJfiU3PoqFcvWUvxcZuCPctHyktYUVIyloUtaJQKxARF+S2GQ5E74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358688; c=relaxed/simple;
	bh=JofqSWCzl11ihkf1QS7aH5EerIGWNBW0jBvqMlbq2a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4EKlXJ1ZszkMzm8Fx21yuaO0VEI4GZyUlhA5DmKUrWBMLBS9gQFnUy7CRBuBIaRb4irBT1jdVhW/556XgUja1EWibp4Jn6a5HSApxTB1ZXB3UStyVq1iPRY/9PZgMPBeqm/o98LSuzqZVeNKOnc9gk5OkOEfywl7IGOWt/MxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1342511566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358685; x=1762963485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQtbK0HPx+N0NDzFM7oR+NUAI3H2NYy2UQCcQpjJkTY=;
        b=e/TQQdBWH6HRBAD67s/U+FTBJGyDuPZqfWuBbOAdmamh18F/fUOQ+JCUNz4GoWXY2x
         +W1JqdSGMgL1AB2iMTwPHDmu9dQPQvGluwPZ99EKB5FXu3o99N6dXQTJ7yxgEqIvDKzO
         1jpxRB9csPRuXoIdnFhXbZgQqQVImpxxGxWF7IyReue3JuvtA9vpjXDVxIqyAyoblwGS
         /PFjIouGqRQ0lAzXZLLdd5sMk/qaqVFAi2CsBo6FQUYmN2E2ZT+70IH+nDkLAqy6OODP
         pvvnrS4OFNicdKmOE1fRW6UKPSf9ED7rRORiBDpY/cxA3H+mRVGEK3csqoM8LwG17onc
         ayXA==
X-Gm-Message-State: AOJu0YwCPRpjP+cD93vgwbkF21BGP6Hld7zVEfGiRs/BbeXY1d2Qnuad
	kBAv7q3yX7sST1VqpkS3ZsMaLPfZuluq4egmsV4p4WVe+syQcjMqekDG
X-Gm-Gg: ASbGncuNwhCHiGh/FDensZ9sLuyt959wfmQe52M7/Ki4EgMjHJ7/eLWWVEJqI/HxeFs
	9G1oTrI+DoxNHG0UTfVu7oLV+VoO7J4/+cXA5PgbK3JPEDHA+FBQiEiVYJ7CxD6zFD3p5Tb0IdR
	mPlNQcCD7v2aeKaWPBgIvGKwowD0cVta9QSWikZNWzn4qyEoerG2AFbe/nqcKAT9iIxZaDBy2fB
	KblJrA7y7pKL+OtZOGI5INAUX9JQ192y0wzZdUKkpm2U83SwFlSwsAOZSJllEW6RNz3j6UIREHB
	9uSJkd5PjRxVnYQWnPZHQF1VYIOvJLRO5llQqj45bOu4rrME/UnKIGGlh1oNShCR3vvc2y+Q7r3
	1s1DrAreWOE9/+wUeeV6rK/YLG6i+AF1GXw/Vqal/ax9dP9wibt7TUWMF7bgIIrJNXg0=
X-Google-Smtp-Source: AGHT+IFeg0PfZi72Z71d5ee0yOEa03D5xAyx6X2QALCBR3Xeog/mqq1XoLJB5RS10SM8/uMZFbIGPg==
X-Received: by 2002:a17:907:9815:b0:b71:854:4e49 with SMTP id a640c23a62f3a-b72655edfabmr373939666b.56.1762358685029;
        Wed, 05 Nov 2025 08:04:45 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2597sm528556266b.45.2025.11.05.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:04:44 -0800 (PST)
Date: Wed, 5 Nov 2025 08:04:42 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v8 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <sw7wovxj7l43rj2dkvapzl3w6rrbai5qje4zswz6xrxmmkyxtm@gym66qdsivwh>
References: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
 <20251104-netconsole_torture-v8-4-5288440e2fa0@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-netconsole_torture-v8-4-5288440e2fa0@debian.org>

On Tue, Nov 04, 2025 at 09:37:04AM -0800, Breno Leitao wrote:
> diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> index 6bb290abd48bf..57f5a5d5cea67 100644
> --- a/tools/testing/selftests/drivers/net/bonding/config
> +++ b/tools/testing/selftests/drivers/net/bonding/config
> @@ -1,5 +1,6 @@
>  CONFIG_BONDING=y
>  CONFIG_BRIDGE=y
> +CONFIG_CONFIGFS_FS=y
>  CONFIG_DUMMY=y
>  CONFIG_INET_ESP=y
>  CONFIG_INET_ESP_OFFLOAD=y
> @@ -11,6 +12,9 @@ CONFIG_NET_CLS_FLOWER=y
>  CONFIG_NET_CLS_MATCHALL=m
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_SCH_INGRESS=y
> +CONFIG_NETCONSOLE=m
> +CONFIG_NETCONSOLE_DYNAMIC=y
> +CONFIG_NETCONSOLE_EXTENDED_LOG=y

I've just realized that check_selftest discards the '_' when checking
for the order. This means NETCONSOLE should come before
CONFIG_NET_SCH_INGRESS.

I will wait for additional review, before updating.

