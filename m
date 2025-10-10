Return-Path: <linux-kernel+bounces-847910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2822CBCC01C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD9C04E6741
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B5279334;
	Fri, 10 Oct 2025 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="W3fZDnak"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9E240611;
	Fri, 10 Oct 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083180; cv=none; b=K5RuVwNt5flH6p2zQM8pY5+nEfiWJBHRZBMFwybWT42IP6eh/6+LI+VW1IECyxw2FNodaAEveIiSQe2Xtz4ylyy8o6WDeFg6Cw6374uyHLnfSDf+fPl5kgh8qe+lx3FTvmFRDdMbQkP8RBM8CJgzJ4T5JKGpZrqFBCTaRWv/UME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083180; c=relaxed/simple;
	bh=cwzXZJMQ9veNsPbymfWTYkdncmeRxgpn5OOYkZ9CWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixZC+CRAmdnQVLvRmdpdDttYu2tSisDEBPBHNAQsXDfEqpJo8axiSPPzSL2khDpjeIvh3yZThM4jZqgflq1GcEeZqDbw4+qPvb0H3JlEDhMZdBrDbDDvgwrmLLj3tOdZQUFnLLlazQT2dTXeZGmwAlWjEQmw4X0tmziHrPUziiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=W3fZDnak; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760083172;
	bh=ryvk948G0hUwxcIpgCWYVy6VTTNrOofkr8sQj/xcotg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=W3fZDnakErjXOE9CzKH8dNzzpLuUbUNBDjhZjfAcVV8TPGD6b4QjtnHKbkpfRg+Rn
	 O2nDxz9geAzJi/nB4+TJ+AKDxbxTx0F7+bbfJmMP3+IBlEmBf1CJdz9E4yA8QSyA46
	 nC/3kF/ZpXBhj+PiU7aynPEnlvJXCB1eRh+CubaQ=
X-QQ-mid: zesmtpsz3t1760083166t0a669ca3
X-QQ-Originating-IP: gaJRMR9DaScPqBBUF2mdYPW3jpEyOXAsEiDReItSkZU=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 15:59:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8123199727091169635
EX-QQ-RecipientCnt: 15
Date: Fri, 10 Oct 2025 15:59:24 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] riscv: dts: spacemit: add Ethernet support for
 MusePi Pro
Message-ID: <911EFAEEDC29225C+aOi83IaxlWmKdoSc@kernel.org>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
 <20251010-k1-musepi-pro-dts-v2-5-6e1b491f6f3e@linux.spacemit.com>
 <a02aec9a-976a-4b63-86cb-126b8ae71185@iscas.ac.cn>
 <59657BBB86F7B678+aOilnA5Z-QL7xF9O@kernel.org>
 <20251010064310-GYA1439398@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010064310-GYA1439398@gentoo.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MyGxsIOb0LTk4X6osbbqTsAlCZ3inaPhjPJkCVRfUt/krTGTXdACjJrI
	17yZtBj1w0KOLusntn1XuBsVsczxmlgmPkAc1f5D4nSEG0pyjh+y7OEfLstFN/VWqC179Qb
	V+mpkhNlFP+Vl9NIuOC2uiNiMObqw66pBoddpIm112NjAB3zWb6RcJvdSCtos0pN+W7ojUR
	onRgPZrGHBWMCxqcauvVVPYtJ3s8K6mlITzpg4PVBKA6MXNm0cUhlPCcOt1i66jSjY6cPvX
	fmKhfknF+srF5FmDYhnp7FO4Yc60IsBI0YLpx4TIb41hK8pYyylfqvVKHb2JPKXnYuSXg59
	WDqqQa5/WbhnwyY1c2Vnj0CWC7fkQHuGCUAWcQ0msFXiC/K3mM5C8Sd1v4/+WndFyiuRfOd
	Zn9HJ+ppIRuToHbRieq1viQrKJgT5XWgGUBKIASQn5vYG6q/inlRDdeee1TAPZkFKfAmz5Y
	nhizYYkTgX9+mbpgc57yeyoZ3XtVuySUTrZEizcO9is5KiBb1C6XFPjE0x598AQ50CpQUtn
	Gibl2RmPor3c0cQyw6pN66edY5W7T7T7nU8Lc5U15dhri17l3aLq32XfPjhzBlvOBaznSlH
	JQPIj7ckyd6QSJ5KOhWuAAduj3Hdmmf2r01xSTieL7Z3jr3c9q1MEqJNHqpQd/6zzQMbSma
	bQGxQ2wXhPK7+1KiNdeZhJqfXlglnYdzK4myd/h2+EhoU8dz2RTDwhCtajIfk0r9zfwZcxw
	5athPmSn68+PxK1bzTFSi27Tdd1kN6wtWvG8ckH13lwE/JKt43aWGZHGOEapDpB8JByriwo
	JYPKty/xOpnosf2h+gbset1+ln6ueEigZTPXJeb71Z4H85hKUILf+YBuJ/DDWexGVGKTXAk
	pWbl3kE1cUMIjz9wBqPc5IwL1X7FDyKvxi9ioOlWKizOEuySSMLa+vVi9eZxtURKFYfCele
	5lgVq/dhA9pMb1iZKULAioFOv+khC7zQQlrkGga52+COJf+Mf6rqsVyuZ+NGoYMcrW+I5WZ
	zRUAjcQbNSmvwBtGqJ8C2fcKhrhCr7/8lz+lWFshKpKwKQZxUCiItBDNRQHP5kdLpiL1RDf
	Q==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, Oct 10, 2025 at 02:43:10PM +0800, Yixun Lan wrote:
> Hi Troy, Vivian:
> 
> On 14:20 Fri 10 Oct     , Troy Mitchell wrote:
> > On Fri, Oct 10, 2025 at 02:13:31PM +0800, Vivian Wang wrote:
> > > 
> [snip]..
> > > 
> > > Maybe Yixun can chime in about this as well.
> > We have talked here [1]
> > 
> > Personally, I think splitting them makes the commit history clearer.
> > I'm happy to merge them if others also think it's more appropriate.
> > 
> I do not have strong preference, either way is fine for me
> If you plan to split the DT into fine patches, then go ahead
Thank you for your reconfirmation

                    - Troy
> 
> -- 
> Yixun Lan (dlan)
> 

