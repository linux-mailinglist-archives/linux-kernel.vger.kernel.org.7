Return-Path: <linux-kernel+bounces-852637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0A1BD9877
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EFC546E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AE12116F4;
	Tue, 14 Oct 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5WuHwNM"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C615530C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446916; cv=none; b=gb4V4sZyQup2NBaS+LQzQXpRxhYnRe4h/s/DwUkFRw+jE6QmjzAK1gz/gn1aTMMk1Ezdklq2VAhCfYHI5Lj3cTUDmagbohe0Y2xHAtNdj4ub4RtAhwUCxW0hdHe/tDcTJIeeDvantbp6OfOk2y23W5UQHpsqqG7OwXvPxqc3Y9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446916; c=relaxed/simple;
	bh=2PZ7Dxiux29sn2cxLLbfjy5baL0JUF5GxdCqMf2A7vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwLhtBBrF0eEGmsFllA1cU1m5xnJX0KZJHXYDXvOT7jkWlwMTpAE91KqOuozD/VbuEWj6OVYawyjzAEjUlRmEsm16pdO1+mCwAYU+TZOZZRQCJH66hbDCRVDnja7fHdd43uR5/2N5izbSfHXnEk1YGBmmibaUfd0xa/Qiz+C0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5WuHwNM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so3165609f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446913; x=1761051713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Orem4t6QfSI5JFiug2h5DjVy4ER1OmliqxRluIkKeWg=;
        b=X5WuHwNM3pxJoKh2q75+gfboP50bMXVfYAczv0kox+2KJ8OpzfKOq8AVucrnCXVnLv
         Az92vUSAhz0QjQGDyuFb3UdnmhKP74BEwSQOasnxOMlu7gY8hsoPo9avdafBoshXokDh
         woRq7tMdufnWEmYVhmXbNbudYkrFC+khWf6GC8vzhbgWCcNs3iEjQ6beMEAnbMyC3myU
         s08+94Dr+GwbPdoF1ImXT1KXGZ+1fBuqgCsHLzU0DL2TWUJV8tNahrf2xP3t0D+HOzxz
         HpFH6QCOLS42ek8ah0KeZEJNCYbIuSfxaSpW6g1cwwaVyf01IA3QvJphpwMz9dd30y1R
         NmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446913; x=1761051713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Orem4t6QfSI5JFiug2h5DjVy4ER1OmliqxRluIkKeWg=;
        b=rEelVAN6qqcRhdFR2ifC/4JvIVZaRMV/lHq4HXa8VZz1Vrk+KMFBk1z8O/owd59VWj
         g/iVka+dEzQ2D7LALnJnzlvgEAy0KU2ZoIGhQYThz5PObjUdHOTSkqDk+heVLykmLQv9
         LZGyAssPsQ3HufKTAdhY7Af9YTDC5ctD7Z0uucghhpovVsRjgArLPmSM0JAZ5n4ZR4E8
         uFlLhUrs+ZXL0fSLGdBlqq5xuhPzqMiR9Xb3gwcTlo5iDiKXD5LRtkTfK7DrD/kK4gVv
         eAZMSGQbPmEbHVdc/It4/7jX+OHkFU35pqNGHo01Ga4x4OE+tW88H/9T2sW87rwV6v/X
         rcMw==
X-Forwarded-Encrypted: i=1; AJvYcCVBQ3OBGmD/5kLcWfoUx8WfHvepG567mgrpPZzheaq7cbGqwl+o73f6x2vsppU1LEOjfPPj6m2YgiEZ7eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznVwWmHfvJPqSaZtlPtp7EaUDIrVzVnvf/VHaorJM+GTVuoEul
	eoROGhOPHRoNq8iZI6Co1qWXTh8cgE73CgOfBGxJpsihzO88MxeF95yt
X-Gm-Gg: ASbGncuHmrx4XC/sMXKnLbGNW+b4LbU6o1NZBfvYpD+1I07DoI6Mv45xGLAz4tu4qKO
	mKqHrlpoZRRONNysZEvQ6US4Pji1fgHlGJuSBDvEZDMpNDGDEBCpMERtFjUfEfCb5NdZpIUpAF5
	etVyOi1R9mwUAZy6oNvsqts7/D0dYJPOnByDsdDN/rONCnE0/5+he24bh9jxHv9CQlDzfTjlzjD
	9IXvLSRYZEvNpJm7o4HRF/zM22Tfaa6fj0wNEty+QoaToqbWsamGJo1/gEd+C4xfNqTzA6bZpsw
	T+NYNkfXkXas6e7G78SVJiwCL3cmBa13xMK1pDdXfr2E/cntf5GHTLFncfvGoEolT+F3ZtBJWxZ
	NzDAuyeuWG2n8uJ8XQNNNGNfLyhZZdGQC6hBWcOGdjGC/iCwiyA2bK4OdcULhLEETWZ/OUCDqfA
	==
X-Google-Smtp-Source: AGHT+IGZAuguHs2vAFoS95VzADN/By/zVpX3eGPY3Q5ZY95Qs8yWuNrHeiJWEnxBhgf85YsKK7wXPg==
X-Received: by 2002:a05:6000:2c0c:b0:3f1:5bdd:190a with SMTP id ffacd0b85a97d-42666ac3a16mr15370706f8f.3.1760446913058;
        Tue, 14 Oct 2025 06:01:53 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf790sm22831336f8f.28.2025.10.14.06.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 06:01:52 -0700 (PDT)
Message-ID: <2ebc6019-d8b6-4d6f-981e-a61819b67e19@gmail.com>
Date: Tue, 14 Oct 2025 14:03:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/24][pull request] Add support for providers
 with large rx buffer
To: netdev@vger.kernel.org, io-uring@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mina Almasry <almasrymina@google.com>, Willem de Bruijn
 <willemb@google.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, David Wei <dw@davidwei.uk>,
 linux-kernel@vger.kernel.org
References: <cover.1760440268.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1760440268.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Oops, should be 0/6 in the subject.

On 10/14/25 14:01, Pavel Begunkov wrote:
> Many modern network cards support configurable rx buffer lengths larger
> than typically used PAGE_SIZE. When paired with hw-gro larger rx buffer
> sizes can drastically reduce the number of buffers traversing the stack
> and save a lot of processing time. Another benefit for memory providers
> like zcrx is that the userspace will be getting larger contiguous chunks
> as well.
> 
> This series adds net infrastructure for memory providers configuring
> the size and implements it for bnxt. It'll be used by io_uring/zcrx,
> which is intentionally separated to simplify merging. You can find
> a branch that includes zcrx changes at [1] and an example liburing
> program at [3].

-- 
Pavel Begunkov


