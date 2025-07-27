Return-Path: <linux-kernel+bounces-746970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFFCB12DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 05:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B483BF1F2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 03:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D4117A317;
	Sun, 27 Jul 2025 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dcyvDocQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E841EA80;
	Sun, 27 Jul 2025 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753586194; cv=none; b=ZplWvGDDRILMJmdI8MfjMskuJjS4d8TW21uErLUqwL07L3k/18JchxxEfv74t9UlITBoAb1H6U9I8PWqcXKbZnrVvtDpt6KeVU0cqIQDHK8TUxSvReHlDJhyhB3ii+Z+HoJ2ZvcDnsFCG6jCCRcS9nTY+gaS5NcEZYIVtsbhzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753586194; c=relaxed/simple;
	bh=Qu68x5uFBhuhZdmuhJCv4Z0Ghrf3p1qZSM1EBIiZ3rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtzTyG5qbhlpnuMT18XEPy4nfA0gTPmM/+HHTClxHrVbz/B/QOo26vwLX9JLFLX6Uxn8y2rxYKn8e9edpMe8Fh8rpoq+VIHXGXHb98q9AmtjfeTf3UfcxOJlgr+bdBgOmuWWwEsexyLXhI+AQWBY2XzicGtlXEOUU8SpYECaBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dcyvDocQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Nf6i8i5Bkb7OgFxi+NnJxOV8Z+WG5sWjgDZOXxkq+Oo=; b=dcyvDocQBTkUlCG8gWpXyNuBV3
	TqMIJK18XoYXBrTJjBPupYKOwDg19h2T0CF3GYz5kv9WDGMhTkkeSGMlwTxxWLuQlN4oqppld/DLE
	QoTYKGvH1fVrDGUlvffjSF/H6uitNdxnaMarc487QNo1YZPbQW7snIWnnuVD3p2A31H6JKPAIVPWu
	ijKCwCygvpJ7cLCENJ6WCrd/3jE5VbSW+zhjMNKclpkJKYAFaUj8kWqMb1F54EhjDUo2GXPDnpx3e
	2JJt16GydlWt2PTXKCs88NLkytx00SuQ50O7PesrAJ9BvIP0UR4WHYryEnmDRGG4ZQGQTeI8SVW62
	LmBH+K2A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufrsA-0000000CHfl-2gU4;
	Sun, 27 Jul 2025 03:16:26 +0000
Message-ID: <1412ff8c-50ff-4e51-b1c5-a4a404aafb86@infradead.org>
Date: Sat, 26 Jul 2025 20:16:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: Fix typos
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250723203250.2909894-1-helgaas@kernel.org>
 <20250723203250.2909894-2-helgaas@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250723203250.2909894-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/25 1:32 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  .../PCI/endpoint/pci-endpoint-cfs.rst         |  4 +--
>  Documentation/PCI/endpoint/pci-endpoint.rst   |  6 ++--
>  Documentation/RCU/lockdep.rst                 |  2 +-
>  Documentation/RCU/stallwarn.rst               |  2 +-
>  Documentation/accel/qaic/aic100.rst           |  4 +--
>  Documentation/accounting/taskstats.rst        |  2 +-
>  Documentation/admin-guide/LSM/SafeSetID.rst   |  2 +-
>  Documentation/admin-guide/RAS/main.rst        |  2 +-
>  Documentation/admin-guide/blockdev/paride.rst |  2 +-
>  .../admin-guide/device-mapper/vdo-design.rst  |  2 +-
>  Documentation/admin-guide/hw-vuln/mds.rst     |  2 +-
>  Documentation/admin-guide/kdump/kdump.rst     |  2 +-
>  .../admin-guide/kernel-parameters.txt         | 10 +++---
>  Documentation/admin-guide/laptops/sonypi.rst  |  2 +-
>  Documentation/admin-guide/media/imx.rst       |  2 +-
>  Documentation/admin-guide/media/si4713.rst    |  6 ++--
>  Documentation/admin-guide/mm/damon/usage.rst  |  2 +-
>  Documentation/admin-guide/perf/hisi-pmu.rst   |  4 +--
>  .../quickly-build-trimmed-linux.rst           |  4 +--
>  .../admin-guide/reporting-issues.rst          |  4 +--
>  .../verify-bugs-and-bisect-regressions.rst    |  2 +-
>  Documentation/arch/arm/keystone/knav-qmss.rst |  2 +-
>  Documentation/arch/x86/cpuinfo.rst            |  2 +-
>  Documentation/core-api/irq/irq-affinity.rst   |  6 ++--
>  Documentation/core-api/irq/irq-domain.rst     | 36 +++++++++----------
>  .../bindings/sound/davinci-evm-audio.txt      |  2 +-
>  Documentation/devicetree/usage-model.rst      |  2 +-
>  Documentation/driver-api/vfio.rst             |  2 +-
>  Documentation/filesystems/erofs.rst           |  2 +-
>  Documentation/filesystems/gfs2-glocks.rst     |  2 +-
>  Documentation/filesystems/hpfs.rst            |  2 +-
>  Documentation/filesystems/resctrl.rst         |  2 +-
>  .../xfs/xfs-online-fsck-design.rst            |  4 +--
>  .../firmware-guide/acpi/gpio-properties.rst   |  4 +--
>  Documentation/hwmon/f71805f.rst               |  2 +-
>  Documentation/misc-devices/apds990x.rst       |  2 +-
>  Documentation/mm/hwpoison.rst                 |  2 +-
>  Documentation/networking/can.rst              |  2 +-
>  .../ethernet/ti/am65_nuss_cpsw_switchdev.rst  |  2 +-
>  .../ethernet/ti/cpsw_switchdev.rst            |  2 +-
>  Documentation/networking/rds.rst              |  2 +-
>  Documentation/power/pci.rst                   |  4 +--
>  .../power/suspend-and-cpuhotplug.rst          |  2 +-
>  Documentation/sound/cards/emu-mixer.rst       |  2 +-
>  Documentation/trace/fprobe.rst                |  2 +-
>  Documentation/trace/ftrace-uses.rst           |  2 +-
>  Documentation/trace/ftrace.rst                | 14 ++++----
>  Documentation/trace/histogram.rst             |  2 +-
>  .../translations/zh_TW/process/5.Posting.rst  |  2 +-
>  .../userspace-api/media/rc/rc-protos.rst      | 20 +++++------
>  50 files changed, 100 insertions(+), 100 deletions(-)
> 



> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9..09f319f8e8ce 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt

> @@ -7390,11 +7390,11 @@
>  			section.
>  
>  	trace_trigger=[trigger-list]
> -			[FTRACE] Add a event trigger on specific events.
> +			[FTRACE] Add an event trigger on specific events.
>  			Set a trigger on top of a specific event, with an optional
>  			filter.
>  
> -			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
> +			The format is "trace_trigger=<event>.<trigger>[ if <filter>],..."
>  			Where more than one trigger may be specified that are comma deliminated.

			                                                            delimited.

>  
>  			For example:

> diff --git a/Documentation/admin-guide/media/si4713.rst b/Documentation/admin-guide/media/si4713.rst
> index be8e6b49b7b4..01131c267287 100644
> --- a/Documentation/admin-guide/media/si4713.rst
> +++ b/Documentation/admin-guide/media/si4713.rst

> @@ -113,7 +113,7 @@ Here is a summary of them:
>  - acomp_attack_time - Sets the attack time for audio dynamic range control.
>  - acomp_release_time - Sets the release time for audio dynamic range control.
>  
> -* Limiter setups audio deviation limiter feature. Once a over deviation occurs,
> +* Limiter setups audio deviation limiter feature. Once an over deviation occurs,

   * Limiter sets up the audio deviation limiter feature.

>    it is possible to adjust the front-end gain of the audio input and always
>    prevent over deviation.
>  


> diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
> index a01c6ead1bc0..f259042b12f9 100644
> --- a/Documentation/core-api/irq/irq-domain.rst
> +++ b/Documentation/core-api/irq/irq-domain.rst

> @@ -77,14 +77,14 @@ Once a mapping has been established, it can be retrieved or used via a
>  variety of methods:
>  
>  - irq_resolve_mapping() returns a pointer to the irq_desc structure
> -  for a given domain and hwirq number, and NULL if there was no
> +  for a given domain and hwirq number, or NULL if there was no
>    mapping.
>  - irq_find_mapping() returns a Linux IRQ number for a given domain and
> -  hwirq number, and 0 if there was no mapping
> +  hwirq number, or 0 if there was no mapping
>  - generic_handle_domain_irq() handles an interrupt described by a
>    domain and a hwirq number
>  
> -Note that irq domain lookups must happen in contexts that are
> +Note that irq_domain lookups must happen in contexts that are
>  compatible with a RCU read-side critical section.

                   an RCU

>  
>  The irq_create_mapping() function must be called *at least once*

> diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> index e231d127cd40..9fe994353395 100644
> --- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> @@ -2185,7 +2185,7 @@ The chapter about :ref:`secondary metadata<secondary_metadata>` mentioned that
>  checking and repairing of secondary metadata commonly requires coordination
>  between a live metadata scan of the filesystem and writer threads that are
>  updating that metadata.
> -Keeping the scan data up to date requires requires the ability to propagate
> +Keeping the scan data up to date requires the ability to propagate

   or                    up-to-date
   as in some other patch lines in this patch.

>  metadata updates from the filesystem into the data being collected by the scan.
>  This *can* be done by appending concurrent updates into a separate log file and
>  applying them before writing the new metadata to disk, but this leads to

> diff --git a/Documentation/userspace-api/media/rc/rc-protos.rst b/Documentation/userspace-api/media/rc/rc-protos.rst
> index 2a888ff5829f..c4675a2098ad 100644
> --- a/Documentation/userspace-api/media/rc/rc-protos.rst
> +++ b/Documentation/userspace-api/media/rc/rc-protos.rst
> @@ -11,7 +11,7 @@ protocols can encode e.g. an address (which device should respond) and a
>  command: what it should do. The values for these are not always consistent
>  across different devices for a given protocol.
>  
> -Therefore out the output of the IR decoder is a scancode; a single u32
> +Therefore the output of the IR decoder is a scancode; a single u32
>  value. Using keymap tables this can be mapped to linux key codes.

                                                    Linux ?

>  
>  Other things can be encoded too. Some IR protocols encode a toggle bit; this
> @@ -182,7 +182,7 @@ jvc (RC_PROTO_JVC)
>  The jvc protocol is much like nec, without the inverted values. It is
>  described here https://www.sbprojects.net/knowledge/ir/jvc.php.
>  
> -The scancode is a 16 bits value, where the address is the lower 8 bits
> +The scancode is a 16 bit value, where the address is the lower 8 bits

or                   16-bit

>  and the command the higher 8 bits; this is reversed from IR order.
>  
>  sony-12 (RC_PROTO_SONY12)
> @@ -329,11 +329,11 @@ The scancode has a somewhat unusual encoding.
>  sanyo (RC_PROTO_SANYO)
>  ----------------------
>  
> -The sanyo protocol is like the nec protocol, but with 13 bits address
> +The sanyo protocol is like the nec protocol, but with 13 bit address
>  rather than 8 bits. Both the address and the command are followed by
>  their inverted versions, but these are not present in the scancodes.
>  
> -Bis 8 to 20 of the scancode is the 13 bits address, and the lower 8
> +Bis 8 to 20 of the scancode is the 13 bit address, and the lower 8

   Bits                        are    13-bit

>  bits are the command.
>  
>  mcir2-kbd (RC_PROTO_MCIR2_KBD)

> @@ -399,7 +399,7 @@ https://www.sbprojects.net/knowledge/ir/sharp.php. There is a very long
>  (40ms) space between the normal and inverted values, and some IR receivers
>  cannot decode this.
>  
> -There is a 5 bit address and a 8 bit command. In the scancode the address is
> +There is a 5 bit address and an 8 bit command. In the scancode the address is

              5-bit                8-bit

>  in bits 8 to 12, and the command in bits 0 to 7.
>  
>  xmp (RC_PROTO_XMP)

Thanks for the cleanup.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

whether you make an update to this or not.

-- 
~Randy

