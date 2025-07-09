Return-Path: <linux-kernel+bounces-723955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F6AFECEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24009188A9F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1542E7F21;
	Wed,  9 Jul 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDdDW2s6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7DD2E7637
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073038; cv=none; b=IHE3358D+wVLTBF+Ax1ksAWJd4sqPovSHiTwTu2jDTz7i4P3Bptxwae5ppRriThZQ2H46/CpVUJ2jXS3MN95xJ1okWlbOLRrE1tN9ugKUPH7Jhiz3REhbfgmIOyJ/ISGOQSfNr/zvIt11UaPl2TFGsak0SkY1MdUVxy6VTUiD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073038; c=relaxed/simple;
	bh=z0KeUw8GcTcwQDMmgIgnjnCbBlIeSkXI6NxiN+WQ2ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sigmj8sKtD58txmll3I3cn/0JK5ekqsY0lqxjuMhaScv72RhaXv25pNahca8NmlhOhsbDRVMVt5Nv/l7Z+j4aYq1dQ1UZCn0qY3LFk/2QnocYTyfdWAlQoh+AaY9VAFFcQ3IU+r+U76ILSYe0GNrpubGkYoyqiYwxz4U6m8f6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDdDW2s6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsDh3n8LHJ/HdhnBV4kSQtvnM5Eyl5B2MMoNaxxIWlI=;
	b=QDdDW2s65GzkmW4uEFB+St4/qf6wH3NbFKUhpyDJN30Ekt9bBhijahimUc2EONMPG9n9j8
	kUllBslv7i/Tou3zjUyjfqQr9HeOkthaQyQg3nyu2Cq1TXhLzBoPyvgOfLjAixBxCoWSOG
	9bP77/1lqOYix6oNHFYnC+0s/hx3hPk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-phM5AvVBPRyGf_avNA9oxQ-1; Wed, 09 Jul 2025 10:57:14 -0400
X-MC-Unique: phM5AvVBPRyGf_avNA9oxQ-1
X-Mimecast-MFC-AGG-ID: phM5AvVBPRyGf_avNA9oxQ_1752073033
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so8204f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073033; x=1752677833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsDh3n8LHJ/HdhnBV4kSQtvnM5Eyl5B2MMoNaxxIWlI=;
        b=QGhF5PjQcWdyUlQQjrJn4PbZouXpCMi4GJST9T3QkdPugeSX1dDn5WKjm0mpuNlg7B
         FHdUvh4SSolOEwemc+bxFQ96Ej1/39iDbTI2lS31hCNTjHlXhd4b4WDUC5opO3EaL/+j
         GC/X8uo1Y/flrextVeiN0oA51duGPJOO2hgbYf/x97t0ROJORwZXsjxRaO7WnUVorIpH
         n3HZMTpAbZ1uW1eehQQtKeWO6/TLF8nIyHh2t/qStNK2wLi99+ZiLfHZ6kAxaAcxDClR
         NRdTWlf7ycePgB6R6k6JHPq8t1aPD98h+nu22jL/dQLVc7JfzjzJUImVM2i0VfeyD3zx
         pMhg==
X-Forwarded-Encrypted: i=1; AJvYcCXkRL+wLxm0CgYJ5ZcFzP8BWAOWEqbWf0+/5PeM5+VssnYjPEkau30VWDie0qga9Z85B5i45LQZyfWIjKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZg10klQBB4Il+ejQpmmiufhjBYIL94GnPokanUh0KkIIouGF5
	iej+v7gfWgqAvnvVxErfeH5AG+Vp1Eu9upbrdqPvZzR/ORC5bwfH8XN4Aai/wVTuLYCafqVueEn
	fF+L1VidkjoQNoLiivA2ttgoPNDzUmZx0xt7dda8JU0whCkBg2QNQ/AdcSz3xHpefMw==
X-Gm-Gg: ASbGncu6PgWcvSJTFcrEie9eLH84Ui5eaHmeeI5s+FcsxZ8O2uIQwDTfOqV4gg57rzy
	i0RV95GE/qiqAbK2fZ2kaIXrXOef5Ac7NpWWJcI0LXEtwUKhmAz1SeM8fM0+g/CHoE4AKSY//yr
	Nxns9Ofv8LwbdDJK7NtolA/n+qRJquncdbHaxgebWlqUH4lsolFKdLc54hF47maoAj8pzuaEsx3
	r9tigOb7uQm8KSk2X4HrFQOSnVii5JtnhVEpce5uzRITPqRfX0uqNRyjiC6sWeBIf/jnoLhUcr7
	QCOT0RKRepQ+cViK0kv0WhdSNkk=
X-Received: by 2002:a05:6000:2f8a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5e44e60f9mr2545135f8f.21.1752073032700;
        Wed, 09 Jul 2025 07:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIDgDZ3ueCPe4xupCxLJP+j8s5t9RvUgCvtE3idf3c2mnCCVDXZoHffqrFFHgTqOqncfSl2Q==
X-Received: by 2002:a05:6000:2f8a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5e44e60f9mr2545109f8f.21.1752073032312;
        Wed, 09 Jul 2025 07:57:12 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b975efsm15802090f8f.46.2025.07.09.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:57:11 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:57:09 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mhal@rbox.co, sgarzare@redhat.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, v4bel@theori.io
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <brnvavvmkbxcvzy6ahwyissqnmjl7db2w6yfk5pmipuhuvsdu4@qwoeyioaues6>
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>

Hi Konstantin,

On Wed, Jul 09, 2025 at 09:54:03AM -0500, Konstantin Shkolnyy wrote:
>I'm seeing a problem on s390 with the new "SOCK_STREAM transport 
>change null-ptr-deref" test. Here is how it appears to happen:
>
>test_stream_transport_change_client() spins for 2s and sends 70K+ 
>CONTROL_CONTINUE messages to the "control" socket.
>
>test_stream_transport_change_server() spins calling accept() because 
>it keeps receiving CONTROL_CONTINUE.
>
>When the client exits, the server has received just under 1K of those 
>70K CONTROL_CONTINUE, so it calls accept() again but the client has 
>exited, so accept() never returns and the server never exits.
>

Thanks for pointing this out!
I had an offline discussion with Stefano about this issue.
This patch[1] should address it.
Please let us know if it works on s390 too.

Cheers,
Luigi

[1]https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/


