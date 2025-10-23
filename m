Return-Path: <linux-kernel+bounces-866815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F112C00B70
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF3919C8253
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070130DEB9;
	Thu, 23 Oct 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6h2AZl0"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4230DD3C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218845; cv=none; b=JOs9ndmwXd+RLR83/ySoCAQqb8fHaSuZZXcyuziWuBmmOCSz8Ynwf6/JfbnOE2iz2Kh3Rz8fI5zAIgXjlJuTmmjJ33bySB2PATYXJsfm0qOkNP7LkyG4s1rPSekfwtnBXyoGDzgf9+nrWDduuWFOFwNpuGF06sl6kbQ1dv7/D40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218845; c=relaxed/simple;
	bh=omXtqGdVwaLttMqdnLj+e50P9l/qbdlv1wXvTweGH/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+HOuIFS8OflFQTLyR0jNa+Avcz0hUufkXFnHfF60nDSOVq0yAQGvIhPI5NkRITXQ2nMMtcGod4XwcpSpWjHSkLo/1nz3i0UwQrufwikBXiyksBxIcdougY9aP/5PafuCVp/2DAs1ESnN3Ywl4mrQbBFmyRK0j18EBOeu3+WpTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6h2AZl0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471191ac79dso7536895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218842; x=1761823642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5A/JaBnPQddwxFBHkEH+pN3tR6CjA0uTWCxQ0JnFwY=;
        b=A6h2AZl0uTC2GseDEA2suZ/jOBvgIMvIBE6rNRpTxVH6jkWpt9B2nBQOkplD2/sy6x
         J+wDlS5hj20v3ZpTJWmL1H8VyhPY2FfK2umYGOEzSdfkTNf5xbGI4w/kAOsykCkJWR+s
         YI1VUIf7dqOMQl2h2I6StV7MhVAN7wd1gsVXVaDLaTdGCXMwz/gNKu1umjOoaAlm1lOs
         ps61AAacxyXiRqSnel3htnGoiQ8ZLMIhVHyiOyKdFWfiSm2C0MZDIK0WLZXQKtHtJR8J
         mlfvxis6exuotn4n4lcDzr5mH/RNzv15Rs0vdiKha1LhQckYrvwkhIwSPd0v/QcKY30b
         vDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218842; x=1761823642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5A/JaBnPQddwxFBHkEH+pN3tR6CjA0uTWCxQ0JnFwY=;
        b=JHd/zWb7HHBU6Ctq0VrhxFTJ9Fn/VsEex2zs3BEE0jjJBMl6OWHqyBXipaas2JXCY4
         D96gJ6skfADPJIByraKvDdKjp+e3o/0ZobTyMQuVFqOqP4fKlQBjd8d+tSFIfFt2Iqzd
         A1GH22g9oyJIeD3gWQYD5p0V4BahOHl8nfGUscBFpp/Fe1o6X0tf6G5cMe5lzPHHe6GW
         LMkYhvOLhT2PR3PAVvLie5Gc58jhLm6eGxk5x+pDWfNwuqzze3kw81KtVbm15IAGo0ty
         kjxg4/ohVzP341lRYvulgfIPdrPPckT0AYK5zlyBIenqEfB6FJqtcr+7D/GomJUolgeh
         9tuw==
X-Forwarded-Encrypted: i=1; AJvYcCV1wzVh1CWcfJcDsfZD3LQ7WaVweuDA6gWFrj1pKF9UIExyHSALd7ZCFt9Rxlkiwhc4Uf7dLXslpXbG9kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGu8/kKO4WVsRIIhwwK0yg4ZD+07mA+XA2xE2MPOqtQZyTwOvl
	DmSCQKlql/BUXKum67USJ7tcVIFT4gsCe2LUMWPi745E1KgXKpXsqgbr
X-Gm-Gg: ASbGncuf20IiKZ4qXL3ZwYFnOz2S01EV21NaKYdtK2GGHJZpbFtUl9XXs3eOix5Qgze
	rOXd59cuPKe/Fr5fkex95HqvfbBZc2K6KhN6jpBtYUOypsgNySeRDEF1wf5Q7VRa6pTVv9/QMpH
	hAanJsCYONRNOpi1kTJYW+pX1mzGeJzCmUupN16eYfD6X75c+l0g5px/vsoNAhMFm7bwx5H9moW
	DD5GNyO75CpK30LdqQNJUpiXG+d5r6csm2PE+bB0rpa/rQVYsToYQ0pCYfoput95WtX7rnBVWxa
	biM+pEbhoLN0wdpS29MqBSI+I7LAUax8LQjgIjcboPUiGdjr3Br5xSH7kgJDgrXgCVK3CSwbTCp
	jY+SOk/aCB5omnlBgCn9kQj/2+GqMf/kmCdbnDEJCIt6lRr757EuiKkY/XPfC2NX2XFXVNGRwV+
	YCDArnRGE6RFD94YrkQTnh+wF4NzgknMqIUSx5UG8a3aFf/LM6j4coi4zeyq/tIsQ=
X-Google-Smtp-Source: AGHT+IFWosB3kP1cunqsyc3Wf0i3HHGXOo97SMwmCET8H8ejn6hdK+I4Wg/ThmA0FKOUA8GfgazJig==
X-Received: by 2002:a05:6000:1a8a:b0:428:3f7c:bcf8 with SMTP id ffacd0b85a97d-4283f7cbeefmr13605166f8f.29.1761218841399;
        Thu, 23 Oct 2025 04:27:21 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f53bcsm3516370f8f.11.2025.10.23.04.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:27:21 -0700 (PDT)
Message-ID: <bf3d9390-f1f6-428d-b47f-81d2ed1707e9@gmail.com>
Date: Thu, 23 Oct 2025 12:27:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sfc: fix potential memory leak in
 efx_mae_process_mport()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alejandro.lucero-palau@amd.com,
 habetsm.xilinx@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20251022163525.86362-1-nihaal@cse.iitm.ac.in>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20251022163525.86362-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2025 17:35, Abdun Nihaal wrote:
> In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is
> passed as a argument to efx_mae_process_mport(), but when the error path
> in efx_mae_process_mport() gets executed, the memory allocated for desc
> gets leaked.
> 
> Fix that by freeing the memory allocation before returning error.
> 
> Fixes: a6a15aca4207 ("sfc: enumerate mports in ef100")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

It might be nice to also add a comment on top of efx_mae_process_mport()
 stating that it takes ownership of @desc from the caller.

