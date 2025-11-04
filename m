Return-Path: <linux-kernel+bounces-885149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C65C321E5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056933B3DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA5335567;
	Tue,  4 Nov 2025 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToPNPUJp"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446333555D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274652; cv=none; b=H3j/+uHdvyyoEuI0j8RA+45AANU8OYN1ZmeZN8+HUvQAHmzU34/6645AKr1nyjolwOfj9DcAs6T/c6EdgZDIt+9cci2aiMCpPZV3p/M4VHkb70UXYby7o+WnvutBqXI5kzcSh5jzdLmlrsxVaPTt18qih8WxtTZifxMKko29CE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274652; c=relaxed/simple;
	bh=+6f8Az2YKgzFu/1Z87heVILzg2DKfZEbBe/3yhgUVjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQ0vpNFM9+Hfn3xMOe436U/tGA43qeyQ/z7eu1n8P2tq6T/SIaVXXEtx2/NJrHw0lv2s2SPLgEfKA4VYQGzuHbbhyuJjruPnkjUMuxy1Y5PoFdoXeNBD2ZQmN4t0WuNGOrYvjH9C9jAVL6Zhg+M/VWrXGQVOFD7mDb8eP1QGLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToPNPUJp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so3927003a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762274646; x=1762879446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XNBFrCMvQ0mThH8RnIZnBD+qXuvr6aMextqQVAw5+04=;
        b=ToPNPUJp2Rs9m0LhRfO2tOdPfb301XtdplVuKe/idtkl+A57r3F3HStgUeL2/FfEKR
         c+IDrRpcqcB9Okh1BboxlCLd+deYo3Nf6SdriZSP82juPzKRXpRoPUAqhOP6B03IJZgC
         JzBFX6XE871Lo3L8CZ/7vmTJSuk+8+7mVNKwZZqNOpXnpTok2UdErl7bvRUu6y66RkM7
         9cnHABGyKJRNUZ8BRb65m+zFAEThzeBEkwXAgOeP81uUDmx1eQ8XOEGlYgUSS7H92QNV
         bAK6dhf/gKaSiFETvqzvNFDUB9Wp34PXMO6KHYtUuMvGtuT9SAi4zaD7FA3ngSNDigYr
         /ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274646; x=1762879446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNBFrCMvQ0mThH8RnIZnBD+qXuvr6aMextqQVAw5+04=;
        b=tWXQXWcz0dPmN8og1XAIPcErbfnb2PM0B5y52EKmo+CbSHslJs3x4b9LWbTmQpthSi
         0/f3MBr61a8Vn0kg2SVh1U+d8COXmCfrMV2YQy67s4/A3MVXH1J/VIOPpk7/FwIWDSPo
         hcSBZInYI2NcXVGvbUMf55Yyfv1xDzTSSnMolX7807QgAGSm8BowzS/A972qIGAjwPLo
         TXnh+Oklow/d02ciHmONIZnkrsQrT//9ieCna+Wgveu+VOTm3aMoCzEkuySfOZSIuP82
         XBNujdNhmHT7aj6CVXuTYmtZfplo55yFvy6DgPb75QIwEH+mDy/hxOFvFbkSWDgHDvha
         8PbA==
X-Forwarded-Encrypted: i=1; AJvYcCUL3pxGKRG+gojpG10R9IUNHl0H6syIiQU4H3vd8HvdwNLgFJBb4XQZc3RYn6Sz81spqHICaQJMYs6xVgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPufcBHI1k3Q6SvdjkRAtMx2B6A/6qrs/8FjbXDM2VnZ37gUof
	haSC22SXF+rbs4p1Xq7oiHhwf3HgWXQGOmjf/kogsHshNvoezPyTbdSw3MR1JXxg3iAAsBW0ZeJ
	qGadj8XrzzWSsfv4Z0F/oZx7eh1jckn8=
X-Gm-Gg: ASbGncsMJFNdM0t++DDPi/cepg+ZWjDmldSRPejSI5gEnEfK2BItkF8rodLHmhOIcSd
	OV4Rp06/WwFkOM1DaNXV7osDfKZtP6Rw8PStYrQmPyHKifsUeKADSQbovE9cS3fItr6LOcHvqPM
	Aw8LdW9YSofE8yFKopniksgIMOq7xAlc+xy6TUZY5Hnanbf3gDj4pSFLcgSkEi6u6ZeKmEcZKzb
	fsJcIyiSkwW5JEtjviVQCqXJmXHwkxi3WX1mhHTyhyEU070LwkRY3LEtRtSkxOMDEsqWilCY+Iq
	wsvm/XxANV4SnxuH6djs+OZjmmsQtbU5Gl/40BCfSHtM
X-Google-Smtp-Source: AGHT+IHjKRUqUHXHludDe/1mTMPgI/bE/8w3FFf+wR3Yq2t0BQji2y5lXCG1ALms3jIeNLLaYlQ5zmmYHpd4jhJyH70=
X-Received: by 2002:a05:6402:90e:b0:640:cc76:ae35 with SMTP id
 4fb4d7f45d1cf-640cc76b080mr5601496a12.21.1762274646019; Tue, 04 Nov 2025
 08:44:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
 <20251028174222.1739954-2-viswanathiyyappan@gmail.com> <20251030192018.28dcd830@kernel.org>
In-Reply-To: <20251030192018.28dcd830@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Tue, 4 Nov 2025 22:13:49 +0530
X-Gm-Features: AWmQ_bmHt-lYY7oXmHpmE0c8MQd7N05CNjm8AaKyi8JrjM3k7rUlxmiFrNq3wMI
Message-ID: <CAPrAcgPD0ZPNPOivpX=69qC88-AAeW+Jy=oy-6+PP8jDxzNabA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config and
 helper structs and functions:
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, jacob.e.keller@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 07:50, Jakub Kicinski <kuba@kernel.org> wrote:

> pls make sure to prefix names of types and functions with netif,
> netdev or net

I think netif is the prefix that makes the most sense here. I will do that

> The driver you picked is relatively trivial, advanced drivers need
> to sync longer lists of mcast / ucast addresses. Bulk of the complexity
> is in keeping those lists. Simple
>
>         *rx_config = *(config_ptr);
>
> assignment is not enough.

Apologies, I had the wrong mental model of the snapshot.

From what I understand, the snapshot should look something like

struct netif_rx_config {
    char *uc_addrs; // of size uc_count * dev->addr_len
    char *mc_addrs; // of size mc_count * dev->addr_len
    int uc_count;
    int mc_count;
    bool multi_en, promisc_en, vlan_en;
    void *device_specific_config;
}
Correct me if I have missed anything

Does the following pseudocode/skeleton make sense?

update_config() will be called at end of set_rx_mode()

read_config() is execute_write_rx_config() and do_io() is
dev->netdev_ops->ndo_write_rx_config() named that way
for consistency (since read/update)

atomic_t cfg_in_use = ATOMIC_INIT(false);
atomic_t cfg_update_pending = ATOMIC_INIT(false);

struct netif_rx_config *active, *staged;

void update_config()
{
    int was_config_pending = atomic_xchg(&cfg_update_pending, false);

    // If prepare_config fails, it leaves staged untouched
    // So, we check for and apply if pending update
    int rc = prepare_config(&staged);
    if (rc && !was_config_pending)
        return;

    if (atomic_read(&cfg_in_use)) {
        atomic_set(&cfg_update_pending, true);
        return;
    }
    swap(active, staged);
}

void read_config()
{
    atomic_set(&cfg_in_use, true);
    do_io(active);
    atomic_set(&cfg_in_use, false);

    // To account for the edge case where update_config() is called
    // during the execution of read_config() and there are no subsequent
    // calls to update_config()
    if (atomic_xchg(&cfg_update_pending, false))
        swap(active, staged);
}

>The driver needs to know old and new entries
> and send ADD/DEL commands to FW. Converting virtio_net would be better,
> but it does one huge dump which is also not representative of most
> advanced NICs.

We can definitely do this in prepare_config()
Speaking of which, How big can uc_count and mc_count be?

Would krealloc(buffer, uc_count * dev->addr_len, GFP_ATOMIC) be a good idea?

Well, virtio-net does kmalloc((uc_count + mc_count) * ETH_ALEN) + ...,
GFP_ATOMIC),
so this shouldn't introduce any new failures for virtio-net

> Let's only allocate any extra state if driver has the NDO
> We need to shut down sooner, some time between ndo_stop and ndo_uninit

Would it make sense to move init (if ndo exists) and cleanup to
__dev_open and __dev_close?

