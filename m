Return-Path: <linux-kernel+bounces-799073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A66B426A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD245E0404
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D632BEFFF;
	Wed,  3 Sep 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca header.b="mAGl66lS"
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca [132.204.25.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347C285C8D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.204.25.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916410; cv=none; b=O4FXbvsqJxHkrXC7aArQmG79Xblk78adtdXgFGWnOYfIg1+Hy1dfrE40OMrtCY8dpgQIgo+X+hi/5xHbFaj9oQ8jt6dKtUnQaas5Pz4OP5EdNG8svgfLQEFL1Koc0wcjj6ix9+GDqgxchTvno/cADaCsLYQXNuSv8FWIS88vGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916410; c=relaxed/simple;
	bh=SUcQePGmeHCu/WKS3/JshufknJE7fwotww7qDUGYGro=;
	h=From:To:Cc:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=VMXAERupV9BQsqcQHWu0Sou140cXWr3f1Tb1r8KuCWAOWWGClOaTnOq2x6TrrJum1ZMhOtONBma6m4XBV4skE/uRmvMYTFAtLyHucONB+javhqLLnDV+GoFfhaMCaYD1AvW5lP3GaQvwXU9p46P9F0UVZtThfs6ud3OIJBCC8Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iro.umontreal.ca; spf=pass smtp.mailfrom=iro.umontreal.ca; dkim=pass (2048-bit key) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca header.b=mAGl66lS; arc=none smtp.client-ip=132.204.25.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iro.umontreal.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iro.umontreal.ca
Received: from pmg3.iro.umontreal.ca (localhost [127.0.0.1])
	by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id B1D7E442386;
	Wed,  3 Sep 2025 12:10:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
	s=mail; t=1756915847;
	bh=SUcQePGmeHCu/WKS3/JshufknJE7fwotww7qDUGYGro=;
	h=From:To:Cc:Subject:In-Reply-To:Date:From;
	b=mAGl66lS3OBF4EKW9BKFBr+HEHGlGgeoJ5oKeRu0YC1q2Y5rfIOwlIJ+gD7zyXxWn
	 sK5TRkY6Cw5EjKrw3wp1iKAn44hT5PlGp13vHM+5dQjfZwKFTxKpH7NjSFWFDRVNJ0
	 skTcbmj2wsDljPR4H+i09gv+ZYvSYHMJO2VcMLL9hkKxsG6+5ywsfmG8wctVj+TTza
	 DEkC0LmH6U4uoD4csK/W6Ki7vRVSmc0aQcprzGGteeg7c5rxJS+kvTcP5EGqMEnkaU
	 SBFDpzp7kMwf9fvQltPyeCEv2uKaHENIqBUy5apCLn8eX9WYbaT0/N7FHZCURextu4
	 i+8FZb4z/tBQA==
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
	by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id 34E2A442382;
	Wed,  3 Sep 2025 12:10:47 -0400 (EDT)
Received: from pastel (69-165-161-194.dsl.teksavvy.com [69.165.161.194])
	by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 14A5212006C;
	Wed,  3 Sep 2025 12:10:47 -0400 (EDT)
From: Stefan Monnier <monnier@iro.umontreal.ca>
To: Dongjin Kim <tobetter@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change ethernet TXD timing delay
 value
In-Reply-To: <aKU2yYD+N2D1KuHk@anyang>
Message-ID: <jwvseh3v8n5.fsf-monnier+@gnu.org>
Date: Wed, 03 Sep 2025 12:10:46 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-SPAM-INFO: Spam detection results:  0
	ALL_TRUSTED                -1 Passed through trusted hosts only via SMTP
	AWL                    -0.286 Adjusted score from AWL reputation of From: address
	BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
	DKIM_SIGNED               0.1 Message has a DKIM or DK signature, not necessarily valid
	DKIM_VALID               -0.1 Message has at least one valid DKIM or DK signature
	DKIM_VALID_AU            -0.1 Message has a valid DKIM or DK signature from author's domain
	DKIM_VALID_EF            -0.1 Message has a valid DKIM or DK signature from envelope-from domain
X-SPAM-LEVEL: 

Dongjin Kim wrote:
> On Tue, Aug 19, 2025 at 06:03:47PM +0200, Andrew Lunn wrote:
> > On Tue, Aug 19, 2025 at 01:50:17PM +0900, Dongjin Kim wrote:
> > > Very poor network performance is observed on the ODROID-M1 Board
> > > (REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
> > > this problem can be resolved after changing the value of TXD
> > > timing to 0x35 from 0x4f.
> > 
> > How did you decide on 0x35?
> > 
> > ~/linux/arch/arm64$ grep -hr "tx_delay = " | sort | uniq -c
> >       4 	tx_delay = <0x10>;
> >       1 	tx_delay = <0x1a>;
> >       1 	tx_delay = <0x21>;
> >       2 	tx_delay = <0x22>;
> >       4 	tx_delay = <0x24>;
> >       2 	tx_delay = <0x26>;
> >      14 	tx_delay = <0x28>;
> >       1 	tx_delay = <0x2a>;
> >       6 	tx_delay = <0x30>;
> >       1 	tx_delay = <0x3a>;
> >       3 	tx_delay = <0x3c>;
> >       2 	tx_delay = <0x42>;
> >       5 	tx_delay = <0x43>;
> >       2 	tx_delay = <0x44>;
> >       1 	tx_delay = <0x46>;
> >       6 	tx_delay = <0x4f>;
> > 
> > The numbers are all over the place, but it is clear that 0x28 is the
> > most popular for some reason. But since this delay values are magic,
> > i've no idea why.
> > 
> >      Andrew
> I do have more numbers in the Rockchip BSP kernel, and 0x35 is from
> one of them that shows less retry counts when testing 'iperf3' while
> testing with the batch of ODROID-M1. :)

FWIW, I had trouble with my Odroid-M1 whose outgoing ethernet bandwidth
seemed to be limited to an average around 100kB/s, when I bumped into
this thread.  I applied the patch and I can now download from that
Odroid at >80MB/s.  So:

    Tested-by: Stefan Monnier <monnier@iro.umontreal.ca>

Haven't tried the `rgmii-id` patch yet.


        Stefan


