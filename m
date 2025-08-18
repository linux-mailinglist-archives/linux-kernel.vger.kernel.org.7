Return-Path: <linux-kernel+bounces-774335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3444B2B12C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FA116E8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187993451AB;
	Mon, 18 Aug 2025 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8PETSV+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F83451A3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543813; cv=none; b=A3P35CJM+/TbYvOusZnehoQCJuqTQGa6ogOoKGPM2hMVy7nBoDIzJxEmE5iA6RIUBC9duNq+30i37QCezmy6+e46FSl1mveFjEHwvgV8V6d6YXh2igD8ZxbfM9TUdudGdi8AnQrq0X5S4u+O68KwiU8DOsGiQ1Ae7Ans3A8cr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543813; c=relaxed/simple;
	bh=+67pc+x9z74A1Tm7iYQ128svS8To5PkK4sRLKDceaus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gd0mMNJ4Pkkzaax5xEnlk+3i+v6UMy0dg7+C/oLYhnVVzVITzKgKEA0EfV03vpxLkh36iQv0B/csaezCbxUHr9vCHze6tvjMmk1WN6w0vm0dgf81I6sNvLL+IeMMvNhK1xnD4KOW8hm5xlHtLkSPsDGmF1Gil/pZWlNXahavL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8PETSV+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755543812; x=1787079812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+67pc+x9z74A1Tm7iYQ128svS8To5PkK4sRLKDceaus=;
  b=j8PETSV+cERwu3SftafvJJAuDiWmZKbQomAOFQVhDFSbPAdBOpfs3OMR
   fN/prwCGU9sK6myLeYmZaYy/iy3ELuOc1WlbzOv9+bdNAScFgQi2j7/If
   dkztaN9BccNkRittBKejdeoWyggRf9I4wS/W8wjySCghuVHkByNbP0Yk4
   9my5NSvjts2CRWWf5lUKlVQzzBSeVwcIxTR5MMGvEd/iIQ7IkjfTtbPWp
   8RNSaNUmgQNjGyuf7frwaHjbpiMhTQD53FNszAKQSaI/gv5RiAfdj//N+
   25CVrWTThVZokiO1uZUqDeZDzWTrsmnIwevXndh0rsQrIHCP9J7l6xh6L
   g==;
X-CSE-ConnectionGUID: 5K2fsitDQxqcZxN11j+Vew==
X-CSE-MsgGUID: yKAuTykgTJGSUQHlMUSQjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="69151576"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="69151576"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 12:03:31 -0700
X-CSE-ConnectionGUID: YlGjlJtKQE6ZrmCDBn78nQ==
X-CSE-MsgGUID: EP+nHCLYQ3Wy+g2t2SYwqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="171890586"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa003.jf.intel.com with ESMTP; 18 Aug 2025 12:03:30 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Alex Murray <alex.murray@canonical.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/intel: Refresh the old ucode revisions with a script
Date: Mon, 18 Aug 2025 12:01:35 -0700
Message-ID: <20250818190137.3525414-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel maintains a list of recently released Intel microcode
revisions for each family-model-stepping. Systems with microcode older
than those listed are marked with X86_BUG_OLD_MICROCODE [1].

Naturally, the microcode list needs to be periodically updated to
reflect the latest releases. This series introduces a script to simplify
this process along with the first update.

Microcode revision update (Patch 1)
-----------------------------------
The update is based on the May 2025 Intel microcode release [2]. Even if
this is taken through the x86/urgent branch, a gap of 3 months seems
like enough time for systems to have been updated. If there are concerns
regarding the timing, the patch can be taken through the regular merge
window.

It also includes a stable Cc to keep the stable trees up-to-date.

The update script (Patch 2)
---------------------------
Below is the help text for the script. Any feedback on the interface or
the help text is appreciated.

$ ./scripts/update-intel-ucode-defs.py -h
usage: update-intel-ucode-defs.py [-h] -u UCODE_PATH [-o HEADER]

For Intel CPUs, update the microcode revisions that determine
X86_BUG_OLD_MICROCODE.

The script takes the Intel microcode files as input and uses the
iucode-tool to extract the revision information. It formats the output
and writes it to intel-ucode-defs.h which holds the minimum expected
revision for each family-model-stepping.

A typical usage is to get the desired release of the Intel Microcode
Update Package at:
https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files.git

And run:
    ./scripts/update-intel-ucode-defs.py -u /path/to/microcode/files

Note: The microcode revisions are usually updated shortly after a new
microcode package is released, allowing a reasonable time for systems to
get the update.

options:
  -h, --help            show this help message and exit
  -u UCODE_PATH, --ucode_path UCODE_PATH
                        Path to the microcode files
  -o HEADER, --output HEADER
                        The microcode header file to be updated (default: intel-ucode-defs.h)

Links
-----
[1]: https://lore.kernel.org/lkml/174530444932.31282.15748299566756052894.tip-bot2@tip-bot2/
[2]: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20250512

Sohil Mehta (2):
  x86/microcode/intel: Refresh the revisions that determine
    old_microcode
  scripts/x86: Add a script to update minimum Intel ucode revisions

 MAINTAINERS                                   |   1 +
 .../kernel/cpu/microcode/intel-ucode-defs.h   |  86 ++++++-----
 scripts/update-intel-ucode-defs.py            | 134 ++++++++++++++++++
 3 files changed, 183 insertions(+), 38 deletions(-)
 create mode 100755 scripts/update-intel-ucode-defs.py

-- 
2.43.0


