Return-Path: <linux-kernel+bounces-731590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0425FB056E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE627B4874
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D42D6639;
	Tue, 15 Jul 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/scXD9g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564682D63F7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572624; cv=none; b=Ed5AIofdMjhYroS5QtFfAlOHg6CEY20EBf7Tj9dLHXk94+uelkN45thail1TNFpjYJfz1hRmnsR9LhABtAvH7tSjyzaPpaNpqThkfowDqjSpblC83CFq30YfeyUF4K/CLwe/yA8TVwEITAszzk4CEVEVDxaOL1PthGGvYNcOooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572624; c=relaxed/simple;
	bh=izVGqEo59aQaJ/J3dKmYZUnzyzOQr38MLYsTGyUr5V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiZCxR2nIgqJdYY05ZviztncQLWDMuNUU/UdOSqpOT4Pnw2X8KMXzKBV5+q2LMlQjzWlc3VDK12iWKxoJ2qFCR8I+C6kV0mo7gsYRebztmARF3fem5AjUR8/XBKbEwuQjUjWPJocUehJaXK1X6Ss426qZSyT1kq1t7+tPGEVU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/scXD9g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752572621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHMd57pfXhcnKNyhyGblHFv+xYATdiBZA7QtN8Jk8ZM=;
	b=i/scXD9gn3sFhebCDM0YGxdKzuxmxltdxJTn573pWYkavICZk2EkJb+U4av+2O1plOj1/B
	veZashgaAeBIlJaIEjJ3rtfyZhkqzEXlOfo7rd+pu5bcLlNgOtJUMpwtQs+pODR4T+Kua7
	eLf8mg7Br6sEn+Iqq0bEhzOD3v9OLLg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-9bdf-JUfOxGRvfrzIhSfMA-1; Tue, 15 Jul 2025 05:43:37 -0400
X-MC-Unique: 9bdf-JUfOxGRvfrzIhSfMA-1
X-Mimecast-MFC-AGG-ID: 9bdf-JUfOxGRvfrzIhSfMA_1752572616
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45626532e27so4666415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572616; x=1753177416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHMd57pfXhcnKNyhyGblHFv+xYATdiBZA7QtN8Jk8ZM=;
        b=g1M6alrCA/aaiFTEJgWSwZlZaeKlMrOBo+Ss3LZK9t1PQKCW5ZGO1j1H05g3RqryiC
         P+T5Q7pPxRpfaI5pH2Nt0pJtSLvpJQuP2XSc/wuubyjbENFjccxdPeKnQG1l3O1jnR6z
         vVmhWC7fN4kxk6M3OB5reovObPpiLCrG3AEeIfmvNJoT+ByiemuCldV9FMzbpIetBiPw
         dBpsoIyoJ0zTmpjFPJ7gZlKZW2KdXBPt5ZKBtxlNAW+zJzJPPZHcW1SCb/V0VfRF7sa5
         JMtcIsrh0ZssqCoyJM0/KpfFq9eB8gV2Ax+uuq2r/oJEKLD3GkPutq0wPN+2eQK7uT+p
         nujA==
X-Forwarded-Encrypted: i=1; AJvYcCVPbXx7tIPC54KNYswinvos25usj/aWzFd/4v6b0r5Q5IW9LJkiVKi1kLB7JpEAlahuCO9mjPBFYo/78PY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/iV7D7/DlWiKvK6nkPDL71K1EvcHwDE6vwf3yrgVLhGtvW1VF
	bD6C3tEuoIXmAOFlakBV673psPK8iOZHxp7/8JiP2oE1uRxvdTNMJU26rAbj5epl/k3yKWYk0l6
	nnzVrkZ/m74yrXk2qJ/NWhuav6Rn3ektvmdKvXjwrOymcCLo+c22TLQLh37ez5h5BUw==
X-Gm-Gg: ASbGncvEsHgZ5BvLWjlmAIKbBCav1ttWxvIbI6D+cAl4OVB9QoZFyQKBH5kMDZPFR7X
	zg/8vBDn/8BpbWFE4I/FyR09jH6co8JYqIAYLbSRTjowyVwPC64TO2/iMxdq2HzoCIyS0fPJC25
	7zOeP0foc4OawNHLQt0YnJSM9iPA3ZJvLalOUFnaVN+4QTMR4UiSohlnNbhh0saXUR1AxpUZOjo
	uZTdplBB2PQ0lrW7KnQ4Fr1Zlxi2EIp3JjKmLQVhO/epADCwBb58JHdxNfc/yZ9koXus0LnrDyE
	vR/euDQSy6SbcvLnuX0x1DKFBgc=
X-Received: by 2002:a05:600c:821b:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-4555f89f507mr187240825e9.10.1752572616447;
        Tue, 15 Jul 2025 02:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN73ANiZ06ERUP471KmOgFnUFAPyMUPH/okS1ibcPZuQjxLvuh1FG3xOFXv+UfdNO1P57u2Q==
X-Received: by 2002:a05:600c:821b:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-4555f89f507mr187240285e9.10.1752572615932;
        Tue, 15 Jul 2025 02:43:35 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1833sm14279030f8f.8.2025.07.15.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:43:34 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:43:30 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Stefano Brivio <sbrivio@redhat.com>, Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Charles Bordet <rough.rock3059@datachamp.fr>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, 1108860@bugs.debian.org
Subject: Re: [regression] Wireguard fragmentation fails with VXLAN since
 8930424777e4 ("tunnels: Accept PACKET_HOST skb_tunnel_check_pmtu().")
 causing network timeouts
Message-ID: <aHYiwvElalXstQVa@debian>
References: <aHVhQLPJIhq-SYPM@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHVhQLPJIhq-SYPM@eldamar.lan>

On Mon, Jul 14, 2025 at 09:57:52PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> Charles Bordet reported the following issue (full context in
> https://bugs.debian.org/1108860)
> 
> > Dear Maintainer,
> > 
> > What led up to the situation?
> > We run a production environment using Debian 12 VMs, with a network
> > topology involving VXLAN tunnels encapsulated inside Wireguard
> > interfaces. This setup has worked reliably for over a year, with MTU set
> > to 1500 on all interfaces except the Wireguard interface (set to 1420).
> > Wireguard kernel fragmentation allowed this configuration to function
> > without issues, even though the effective path MTU is lower than 1500.
> > 
> > What exactly did you do (or not do) that was effective (or ineffective)?
> > We performed a routine system upgrade, updating all packages include the
> > kernel. After the upgrade, we observed severe network issues (timeouts,
> > very slow HTTP/HTTPS, and apt update failures) on all VMs behind the
> > router. SSH and small-packet traffic continued to work.
> > 
> > To diagnose, we:
> > 
> > * Restored a backup (with the previous kernel): the problem disappeared.
> > * Repeated the upgrade, confirming the issue reappeared.
> > * Systematically tested each kernel version from 6.1.124-1 up to
> > 6.1.140-1. The problem first appears with kernel 6.1.135-1; all earlier
> > versions work as expected.
> > * Kernel version from the backports (6.12.32-1) did not resolve the
> > problem.
> > 
> > What was the outcome of this action?
> > 
> > * With kernel 6.1.135-1 or later, network timeouts occur for
> > large-packet protocols (HTTP, apt, etc.), while SSH and small-packet
> > protocols work.
> > * With kernel 6.1.133-1 or earlier, everything works as expected.
> > 
> > What outcome did you expect instead?
> > We expected the network to function as before, with Wireguard handling
> > fragmentation transparently and no application-level timeouts,
> > regardless of the kernel version.
> 
> While triaging the issue we found that the commit 8930424777e4
> ("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu()." introduces
> the issue and Charles confirmed that the issue was present as well in
> 6.12.35 and 6.15.4 (other version up could potentially still be
> affected, but we wanted to check it is not a 6.1.y specific
> regression).
> 
> Reverthing the commit fixes Charles' issue.
> 
> Does that ring a bell?

It doesn't ring a bell. Do you have more details on the setup that has
the problem? Or, ideally, a self-contained reproducer?


> Regards,
> Salvatore
> 


