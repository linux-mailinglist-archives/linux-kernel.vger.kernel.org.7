Return-Path: <linux-kernel+bounces-766928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E45EB24CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA53316DAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDB42F659E;
	Wed, 13 Aug 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XGmuhegS"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A52E8DEC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097297; cv=none; b=HEOFgopEga3lu0WrflUwu2yDJGQTQLvmMoXHhB5KsOTW28d3OV411+iC1sLDABIkKrToudW5mt/PzxlsqImzU6UVWap2IVCFgWBm56wG36Qf6yN9qEKULziCXTQq7TM8b5UwE69wZNZwsarM9FXd0jZEt7Mj3HNOzsAr4VmRKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097297; c=relaxed/simple;
	bh=17p7MwBRCSHE64fa1D2KRWGLUNsrWBqS0NAwyjoJ49k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcdo4gV4McQhwBPY7BndFZV4PvkiWHHHvMtJC0wkNcBcHKG/q8jPoUzGOBUnzXUcyqD0syD37LwzJcPKhx/Dq6MPxbYPzl5+L13+zpoNzklR2aBCaIwbDy+FvWc6eNRkjhbja/YHJbX8ih5ghpS1KL50Tq6L1njsl9e3w8dkvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XGmuhegS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so34615865e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755097294; x=1755702094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je12YbuZgJ4qovK2aDqAlKj+xBOV5nZtHN1wMIqYxUE=;
        b=XGmuhegSWmR0z1eD5VfGaLK4lsnGhjzImb+ike8bZO4hDvXI4lxDj0MYcYeRbgDJ98
         cGvhu/pcDGZ1TrqSZwCOsSLXPyqv2DvpvpUqmIl3cfBYmVgZrNfNGfqKYxOqMGJgK/qv
         kveyeammzwRrx+FoAVBkeByWUssccEkqp0JUI2DboMCsLgJ3VaotKsvn2xa3bI/ic16Y
         lGZdo62M+ofV2pe+3UnRdhCSoV+BBNnd85VkrBRope7gXuuuQCivuD0Zy0znlgIEwhV7
         zDlalYb+XGWJMJkpxRy0NbuKBV3LwXMs/NyAASDE1V1NTkugEeOYI27uFigiSkfywa6X
         0CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097294; x=1755702094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je12YbuZgJ4qovK2aDqAlKj+xBOV5nZtHN1wMIqYxUE=;
        b=kVReJxQ/CPW3YeB3S2AU6o0x6AcCZ/hSeIX82Bq+ro2DVb9yZOmLH3tiRB33LNXans
         B4HVJ9q/YL/e23kjwj+fshIUaEp225RIfReFtvk2oIuf6HE9aBDGS0rY2em5MJHWzICd
         J1aiIOfCntyelwd/zguqv4NBAPFDbW+5oqHCDnyMmfzFzk66phaG0wpSboCtuRHCKHDd
         Wal74mrZTQMy2SWtXsymgKcnGMa1RwxmVUb1+bHA/L9Svb8KIiD76fhuX9VcfaTJaJ81
         eR3G1IdibR1mEWkD6QJsSmVee+UMs+c2jc/zNWI+SbWsX72oGg8h9Yg6a62n7Sk/mL5v
         G6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXtg9yfwJJ6KJJ/7hlQbqjqX03j3cYTpkACHyHcHiBVFSJhRJnZGLZ8K9pk9/4KCtEe6IuAVZqvfmQNT0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOr63l5qKDyNP570hYR3LvIh+hiWl8xLsUW6om+uidvC61Om3g
	APxL8lcfDfrB7Cvl8HMP+zEnYSfgqbL0rbmMnu1Rvsp0if/DikKRm2wXE/kcvXEsgf8PUMyWOpf
	GD9lJ
X-Gm-Gg: ASbGnctcTYoLj25RlTKSz2qXpid8Zww5Mw7+NW+Ah9x02sXIBHjMysPKObIzwSMazkJ
	MOzkYLGyHkQ/KyVlMIAXz9MQ1Y1GznayCwQTlDkB9RbfD0qJyFfYdmCQM6cbDxQPs4QhgFQhV/D
	3uBH23+0n52y/68ng8Ue6HSAyPrl9WMc6W1s0V75fo1suT0/oxiAngQ6bj5jiCNCL6glTSfkMCx
	PO2yg1VC2HrbIxwHEMTQY8z17Pk1e9oetikH4cyAUqyj1kBDQyLXEJnCPcKnhOCtglEaYwo7ajZ
	fK3Udk7I/1DgUgtmDCl4HtdqIK0vpU51boWCSCVQ83Rm1ZUAWRoqRgJNAqQSNqwy1j8+aCSGHus
	rL0XN2Ytgx3++NV9alVgXJ0KDQv8Ckm0mYjmPIlqWvpd/kQFbS0eVUoDONTPON/teMhgHOycjXo
	roJQ0+F/7t4g==
X-Google-Smtp-Source: AGHT+IFXqt5LPuOlEXVdf/zo4i2yFRbcmo4lW7SxAHZ3nqQPMO3z7dPVL58xg/gcGFrW+KBzQ2iajg==
X-Received: by 2002:a05:600c:4f48:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-45a165e41c0mr29476455e9.19.1755097293990;
        Wed, 13 Aug 2025 08:01:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1ab24d1dsm343015e9.0.2025.08.13.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:01:33 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:01:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Gebauer
 <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net v2] TUN/TAP: Improving throughput and latency by
 avoiding SKB drops
Message-ID: <20250813080128.5c024489@hermes.local>
In-Reply-To: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 00:03:48 +0200
Simon Schippers <simon.schippers@tu-dortmund.de> wrote:

> This patch is the result of our paper with the title "The NODROP Patch:
> Hardening Secure Networking for Real-time Teleoperation by Preventing
> Packet Drops in the Linux TUN Driver" [1].
> It deals with the tun_net_xmit function which drops SKB's with the reason
> SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
> resulting in reduced TCP performance and packet loss for bursty video
> streams when used over VPN's.
> 
> The abstract reads as follows:
> "Throughput-critical teleoperation requires robust and low-latency
> communication to ensure safety and performance. Often, these kinds of
> applications are implemented in Linux-based operating systems and transmit
> over virtual private networks, which ensure encryption and ease of use by
> providing a dedicated tunneling interface (TUN) to user space
> applications. In this work, we identified a specific behavior in the Linux
> TUN driver, which results in significant performance degradation due to
> the sender stack silently dropping packets. This design issue drastically
> impacts real-time video streaming, inducing up to 29 % packet loss with
> noticeable video artifacts when the internal queue of the TUN driver is
> reduced to 25 packets to minimize latency. Furthermore, a small queue
> length also drastically reduces the throughput of TCP traffic due to many
> retransmissions. Instead, with our open-source NODROP Patch, we propose
> generating backpressure in case of burst traffic or network congestion.
> The patch effectively addresses the packet-dropping behavior, hardening
> real-time video streaming and improving TCP throughput by 36 % in high
> latency scenarios."
> 
> In addition to the mentioned performance and latency improvements for VPN
> applications, this patch also allows the proper usage of qdisc's. For
> example a fq_codel can not control the queuing delay when packets are
> already dropped in the TUN driver. This issue is also described in [2].
> 
> The performance evaluation of the paper (see Fig. 4) showed a 4%
> performance hit for a single queue TUN with the default TUN queue size of
> 500 packets. However it is important to notice that with the proposed
> patch no packet drop ever occurred even with a TUN queue size of 1 packet.
> The utilized validation pipeline is available under [3].
> 
> As the reduction of the TUN queue to a size of down to 5 packets showed no
> further performance hit in the paper, a reduction of the default TUN queue
> size might be desirable accompanying this patch. A reduction would
> obviously reduce buffer bloat and memory requirements.
> 
> Implementation details:
> - The netdev queue start/stop flow control is utilized.
> - Compatible with multi-queue by only stopping/waking the specific
> netdevice subqueue.
> - No additional locking is used.
> 
> In the tun_net_xmit function:
> - Stopping the subqueue is done when the tx_ring gets full after inserting
> the SKB into the tx_ring.
> - In the unlikely case when the insertion with ptr_ring_produce fails, the
> old dropping behavior is used for this SKB.
> 
> In the tun_ring_recv function:
> - Waking the subqueue is done after consuming a SKB from the tx_ring when
> the tx_ring is empty. Waking the subqueue when the tx_ring has any
> available space, so when it is not full, showed crashes in our testing. We
> are open to suggestions.
> - When the tx_ring is configured to be small (for example to hold 1 SKB),
> queuing might be stopped in the tun_net_xmit function while at the same
> time, ptr_ring_consume is not able to grab a SKB. This prevents
> tun_net_xmit from being called again and causes tun_ring_recv to wait
> indefinitely for a SKB in the blocking wait queue. Therefore, the netdev
> queue is woken in the wait queue if it has stopped.
> - Because the tun_struct is required to get the tx_queue into the new txq
> pointer, the tun_struct is passed in tun_do_read aswell. This is likely
> faster then trying to get it via the tun_file tfile because it utilizes a
> rcu lock.
> 
> We are open to suggestions regarding the implementation :)
> Thank you for your work!
> 
> [1] Link:
> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> [2] Link:
> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
> [3] Link: https://github.com/tudo-cni/nodrop
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>

I wonder if it would be possible to implement BQL in TUN/TAP?

https://lwn.net/Articles/454390/

BQL provides a feedback mechanism to application when queue fills.

