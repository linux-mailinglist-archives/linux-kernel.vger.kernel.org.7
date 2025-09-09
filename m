Return-Path: <linux-kernel+bounces-807042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E08B49F39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB54E31CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4B252287;
	Tue,  9 Sep 2025 02:28:33 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A123BD1B;
	Tue,  9 Sep 2025 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384912; cv=none; b=Kdwc61rKK1Es0Jxi7KQujdhZTmGI+luyjBDyGLChue+MDqlntL4klE/9iSNcxMXeboFeZOkw9z3NAS/sm6DxlM6/1pfbQ8ivNLu+yxTnzdIOqAEDnhwZTE4MJX2pQnXf+vatEA0G4Xn97hQKVQn1vFClZNXIpYB0i07iP4mzZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384912; c=relaxed/simple;
	bh=B9YpAsc7HrPBahGPZFjmZEWy67/rCtyq68IPSstJXpA=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=O7NWg5juED2bpKBYpz6XtBq67iOL/Hmv4YL8/Or4QtSi6/rAh4g5pjUi6YcErmT5f8jLelcOQ42gWEazRU6gjNb9N3Ewsq8s9igutQqDX2rwoF/VMMB4rypvW4OVtKPS4VduQEe0X/iJsWVyGfnoHJhEPeZvbFZFwkIde6f70PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cLSRZ1hdwz5B0w2;
	Tue, 09 Sep 2025 10:28:26 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 5892S8Wq043366;
	Tue, 9 Sep 2025 10:28:08 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 9 Sep 2025 10:28:09 +0800 (CST)
Date: Tue, 9 Sep 2025 10:28:09 +0800 (CST)
X-Zmail-TransId: 2afc68bf90b9e4c-a41ff
X-Mailer: Zmail v1.0
Message-ID: <202509091028097618HQ3ssH5kKvPHOYmx_-YX@zte.com.cn>
In-Reply-To: <20250907001457696qAqUGGkV1VfEO6OkVMovW@zte.com.cn>
References: 20250907001101305vrTGnXaRNvtmsGkp-Ljk_@zte.com.cn,20250907001457696qAqUGGkV1VfEO6OkVMovW@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <fan.yu9@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <wang.yaxin@zte.com.cn>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSHYyIGxpbnV4LW5leHQgNS81XSBkb2NzOiB1cGRhdGUgZGVsYXl0b3AgZG9jdW1lbnRhdGlvbiBmb3IgbmV3IGludGVyYWN0aXZlIGZlYXR1cmVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5892S8Wq043366
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 09 Sep 2025 10:28:26 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BF90CA.001/4cLSRZ1hdwz5B0w2

> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> This commit updates the delaytop documentation to reflect the newly
> added features:
> 1) Added comprehensive description of interactive keyboard controls
> 2) Documented all available sort fields
> 3) Added examples for advanced usage scenarios
> 4) Included PSI availability note
> 
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> ---
>  Documentation/accounting/delay-accounting.rst | 91 ++++++++++++-------
>  1 file changed, 58 insertions(+), 33 deletions(-)

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

> 
> diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
> index 8ccc5af5ea1e..7cca536d2c4c 100644
> --- a/Documentation/accounting/delay-accounting.rst
> +++ b/Documentation/accounting/delay-accounting.rst
> @@ -134,47 +134,72 @@ The above command can be used with -v to get more debug information.
> 
>  After the system starts, use `delaytop` to get the system-wide delay information,
>  which includes system-wide PSI information and Top-N high-latency tasks.
> +Note: PSI support requires `CONFIG_PSI=y` and `psi=1` for full functionality.
> 
> -`delaytop` supports sorting by CPU latency in descending order by default,
> -displays the top 20 high-latency tasks by default, and refreshes the latency
> -data every 2 seconds by default.
> +`delaytop` is an interactive tool for monitoring system pressure and task delays.
> +It supports multiple sorting options, display modes, and real-time keyboard controls.
> 
> -Get PSI information and Top-N tasks delay, since system boot::
> +Basic usage with default settings (sorts by CPU delay, shows top 20 tasks, refreshes every 2 seconds)::
> 
>  	bash# ./delaytop
> -	System Pressure Information: (avg10/avg60/avg300/total)
> -	CPU some:       0.0%/   0.0%/   0.0%/     345(ms)
> +	System Pressure Information: (avg10/avg60vg300/total)
> +	CPU some:       0.0%/   0.0%/   0.0%/  106137(ms)
>  	CPU full:       0.0%/   0.0%/   0.0%/       0(ms)
>  	Memory full:    0.0%/   0.0%/   0.0%/       0(ms)
>  	Memory some:    0.0%/   0.0%/   0.0%/       0(ms)
> -	IO full:        0.0%/   0.0%/   0.0%/      65(ms)
> -	IO some:        0.0%/   0.0%/   0.0%/      79(ms)
> +	IO full:        0.0%/   0.0%/   0.0%/    2240(ms)
> +	IO some:        0.0%/   0.0%/   0.0%/    2783(ms)
>  	IRQ full:       0.0%/   0.0%/   0.0%/       0(ms)
> -	Top 20 processes (sorted by CPU delay):
> -	  PID   TGID  COMMAND          CPU(ms)  IO(ms) SWAP(ms) RCL(ms) THR(ms) CMP(ms)  WP(ms) IRQ(ms)
> -	----------------------------------------------------------------------------------------------
> -	  161    161  zombie_memcg_re   1.40    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	  130    130  blkcg_punt_bio    1.37    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	  444    444  scsi_tmf_0        0.73    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	 1280   1280  rsyslogd          0.53    0.04    0.00    0.00    0.00    0.00    0.00    0.00
> -	   12     12  ksoftirqd/0       0.47    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	 1277   1277  nbd-server        0.44    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	  308    308  kworker/2:2-sys   0.41    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	   55     55  netns             0.36    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	 1187   1187  acpid             0.31    0.03    0.00    0.00    0.00    0.00    0.00    0.00
> -	 6184   6184  kworker/1:2-sys   0.24    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	  186    186  kaluad            0.24    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	   18     18  ksoftirqd/1       0.24    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	  185    185  kmpath_rdacd      0.23    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	  190    190  kstrp             0.23    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	 2759   2759  agetty            0.20    0.03    0.00    0.00    0.00    0.00    0.00    0.00
> -	 1190   1190  kworker/0:3-sys   0.19    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	 1272   1272  sshd              0.15    0.04    0.00    0.00    0.00    0.00    0.00    0.00
> -	 1156   1156  license           0.15    0.11    0.00    0.00    0.00    0.00    0.00    0.00
> -	  134    134  md                0.13    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -	 6142   6142  kworker/3:2-xfs   0.13    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> -
> -Dynamic interactive interface of delaytop::
> +	[o]sort [M]memverbose [q]quit
> +	Top 20 processes (sorted by cpu delay):
> +		PID      TGID  COMMAND           CPU(ms)   IO(ms)  IRQ(ms)  MEM(ms)
> +	------------------------------------------------------------------------
> +		110       110  kworker/15:0H-s   27.91     0.00     0.00     0.00
> +		57        57  cpuhp/7            3.18     0.00     0.00     0.00
> +		99        99  cpuhp/14           2.97     0.00     0.00     0.00
> +		51        51  cpuhp/6            0.90     0.00     0.00     0.00
> +		44        44  kworker/4:0H-sy    0.80     0.00     0.00     0.00
> +		60        60  ksoftirqd/7        0.74     0.00     0.00     0.00
> +		76        76  idle_inject/10     0.31     0.00     0.00     0.00
> +		100       100  idle_inject/14     0.30     0.00     0.00     0.00
> +		1309      1309  systemsettings     0.29     0.00     0.00     0.00
> +		45        45  cpuhp/5            0.22     0.00     0.00     0.00
> +		63        63  cpuhp/8            0.20     0.00     0.00     0.00
> +		87        87  cpuhp/12           0.18     0.00     0.00     0.00
> +		93        93  cpuhp/13           0.17     0.00     0.00     0.00
> +		1265      1265  acpid              0.17     0.00     0.00     0.00
> +		1552      1552  sshd               0.17     0.00     0.00     0.00
> +		2584      2584  sddm-helper        0.16     0.00     0.00     0.00
> +		1284      1284  rtkit-daemon       0.15     0.00     0.00     0.00
> +		1326      1326  nde-netfilter      0.14     0.00     0.00     0.00
> +		27        27  cpuhp/2            0.13     0.00     0.00     0.00
> +		631       631  kworker/11:2-rc    0.11     0.00     0.00     0.00
> +
> +Interactive keyboard controls during runtime::
> +
> +	o - Select sort field (CPU, IO, IRQ, Memory, etc.)
> +	M - Toggle display mode (Default/Memory Verbose)
> +	q - Quit
> +
> +Available sort fields(use -s/--sort or interactive command)::
> +
> +	cpu(c)       - CPU delay
> +	blkio(i)     - I/O delay 
> +	irq(q)       - IRQ delay
> +	mem(m)       - Total memory delay
> +	swapin(s)    - Swapin delay (memory verbose mode only)
> +	freepages(r) - Freepages reclaim delay (memory verbose mode only)
> +	thrashing(t) - Thrashing delay (memory verbose mode only)
> +	compact(p)   - Compaction delay (memory verbose mode only)
> +	wpcopy(w)    - Write page copy delay (memory verbose mode only)
> +
> +Advanced usage examples::
> +
> +	# ./delaytop -s blkio
> +	Sorted by IO delay
> +
> +	# ./delaytop -s mem -M
> +	Sorted by memory delay in memory verbose mode
> 
>  	# ./delaytop -p pid
>  	Print delayacct stats
> -- 
> 2.25.1

