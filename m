Return-Path: <linux-kernel+bounces-781437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C4FB3126B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFAC1C275B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAA2EBDFD;
	Fri, 22 Aug 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ppb45iN+"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01132EBDD2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853094; cv=none; b=Lno1M3kpmxyOnI2SvUxAwRYA0y/hHWTt+0+nWVt/5VEShv8kpjqlwWWMPePG/QqDtqNA0XP15Hzvgez/+S1UyqL9jqwEz8wGOBJ5Ve9j7f2Or1ixJ7c8iiiGvUuWiCxRR5kxNxSXHwN4zhCahCUTUf9pD3aOgm/yGoiBQz1KvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853094; c=relaxed/simple;
	bh=G0MMo12Z1PGEKX4vKjrmceGgqwu822cSEHoyr4uWDzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULCDT02bB7pMLlqvkevWgQQfabaDBkQdVpQT+L7MVB6kVEkd6QeJDnMPzgwphciQFU18bwozwjM3mtuiZQkAZdwVzUi1hM19v0GsUqZO7brxDuO9MuzL51iYL2vw4GrUMIcEpINU4Qjgq8aKAqQvZ9MQKcKShXYZNZIDC7kQgck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ppb45iN+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109a95f09so14046101cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755853092; x=1756457892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iNThgY03lKPbnqEMoEccJzLDFCrKjXktdggiqz7EAH8=;
        b=Ppb45iN+IKLyZbkttkUeK5OlQo1Q3kry+TcgpDpk5RHljzy8/H7jXCAAO+ZWLeDVHr
         U4fCaCKI7YDX3stFX1bumqqqc3LQdSUbq9MlKUVYoYQLKU2TGwqEJR7sYn3RvPgHNxly
         6EeUKMa/DIX7DddhXg9W7/TWxpuP8DQI5fMiUOMCMMyi6mxmU2xq9w4TsQMaNCM8WbHv
         hQerX4ILZmN7NcD+c/awm7AIa55/OC9JoZCjeA3Ci9EeevVPFsfkBG03WI0vv51BWFYn
         DEjp3zESiz8c6HttVtnW1jqeCtkWhgUyZSK127wvukcJ3V0lIPSVMOArQep+eJZLGqkl
         nH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755853092; x=1756457892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNThgY03lKPbnqEMoEccJzLDFCrKjXktdggiqz7EAH8=;
        b=Tg4bzfKNwM3K4kR6uf9MF0h97SpusjeGjFF3+uzq0ZD+2QEYrshqXo0UFDLvlInX8C
         7i+KxtdBwSPOUYMGf38FcrwO3hLW1IYW3ozT7qIpv41YZ1hsOOeCo6EzPIKq4Vp5/a/r
         UjaJTcf88BnBPkTpi5yFbqzvulD+S7utc8ymGj1QdcXtILMd2tMe1KxYfciNoe9wLnGE
         fiyFG9Sypn4CKbU4NdSHTSctk6ble1kQuZBQ78bJ2eR2nK/mB5lkdLqPV8CmE24R6X+t
         Rkepzsru9lBwvFKVZdFM5avBN8gi7Eo01e3NqLyrL+SIqDqL56IzuxLuAW/n2eLcpiui
         IofA==
X-Forwarded-Encrypted: i=1; AJvYcCVGBur6J8v5vyfDCwMAZGLdNFMOyydbqtk5m2WKYIMoRo/kIdgUMuAmTJM+yxyEzy+Ioyp/BS+DjpNIiNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEF0wP5OJmPramHi1gvyS8t4gwTmSwtBMthsQo93fe+F8tgp/
	IqhQHTiZSMAnVgZ58hPKJ48DVrUbeZmKWNLjfgnZEOerbqXJHdhaXVtpAFIxfPDT/5GDjxcTtHs
	8M7IvduERTkmbCRMSmvmhx+My3WNXCdHlqs2RGut+
X-Gm-Gg: ASbGncu988SRUDjX99zlusFIIluJ9E6M6lDFrWRL9Jrr7pvEBoTuDfaXedijnehlAOA
	Z+2gu4IJMhN6P93WqBIqzum2eq32zKaywZl1+N4H2x2FpWIl+wiGk41GaT1kKmGsNiejbuaYIR3
	8UZwvaEQzXpnJ/ePOW47kxUwejBvaotsWKLrCEV75CpET5+a3N0UH1S13QHnbBzQuyRo1qHVnSv
	gv55pSHAZns
X-Google-Smtp-Source: AGHT+IGgJFs81Tkm9cnzx99Wu/VuJAA14zxdl2jbbJSm45ct37oH5geS2KLImcOs+RJFkvoeWeLf9t4MCdcRp1M/isQ=
X-Received: by 2002:ac8:5e10:0:b0:4b0:b7d2:763f with SMTP id
 d75a77b69052e-4b2aab20bb8mr24115191cf.47.1755853091220; Fri, 22 Aug 2025
 01:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813133812.926145-1-ethan.w.s.graham@gmail.com> <20250813133812.926145-4-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250813133812.926145-4-ethan.w.s.graham@gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 22 Aug 2025 16:57:59 +0800
X-Gm-Features: Ac12FXzU8xu8PyzsDwHHn4kmmXyplfDG-OPyeaz3YpQBir8tDT1g8D3RnS31l3M
Message-ID: <CABVgOSkrbAxBUqvSWQ2ME5Vx0SXpCRmN3F-i6qJj=0BEZg_2dg@mail.gmail.com>
Subject: Re: [PATCH v1 RFC 3/6] kfuzztest: implement core module and input processing
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, glider@google.com, andreyknvl@gmail.com, 
	brendan.higgins@linux.dev, dvyukov@google.com, jannh@google.com, 
	elver@google.com, rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d384a8063cf067c5"

--000000000000d384a8063cf067c5
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 21:38, Ethan Graham <ethan.w.s.graham@gmail.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Add the core runtime implementation for KFuzzTest. This includes the
> module initialization, and the logic for receiving and processing
> user-provided inputs through debugfs.
>
> On module load, the framework discovers all test targets by iterating
> over the .kfuzztest_target section, creating a corresponding debugfs
> directory with a write-only 'input' file for each of them.
>
> Writing to an 'input' file triggers the main fuzzing sequence:
> 1. The serialized input is copied from userspace into a kernel buffer.
> 2. The buffer is parsed to validate the region array and relocation
>    table.
> 3. Pointers are patched based on the relocation entries, and in KASAN
>    builds the inter-region padding is poisoned.
> 4. The resulting struct is passed to the user-defined test logic.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
> ---

I haven't had a chance to look over this in detail yet (though I
definitely love some of the ideas here), but I'd strongly encourage
you to taint the kernel (with TAINT_TEST) if this is enabled/used.

Cheers,
-- David


>  lib/Makefile           |   2 +
>  lib/kfuzztest/Makefile |   4 +
>  lib/kfuzztest/main.c   | 161 +++++++++++++++++++++++++++++++
>  lib/kfuzztest/parse.c  | 208 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 375 insertions(+)
>  create mode 100644 lib/kfuzztest/Makefile
>  create mode 100644 lib/kfuzztest/main.c
>  create mode 100644 lib/kfuzztest/parse.c
>
> diff --git a/lib/Makefile b/lib/Makefile
> index c38582f187dd..511c44ef4b19 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -354,6 +354,8 @@ obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
>  obj-$(CONFIG_OBJAGG) += objagg.o
>
> +obj-$(CONFIG_KFUZZTEST) += kfuzztest/
> +
>  # pldmfw library
>  obj-$(CONFIG_PLDMFW) += pldmfw/
>
> diff --git a/lib/kfuzztest/Makefile b/lib/kfuzztest/Makefile
> new file mode 100644
> index 000000000000..142d16007eea
> --- /dev/null
> +++ b/lib/kfuzztest/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_KFUZZTEST) += kfuzztest.o
> +kfuzztest-objs := main.o parse.o
> diff --git a/lib/kfuzztest/main.c b/lib/kfuzztest/main.c
> new file mode 100644
> index 000000000000..fccda1319fb0
> --- /dev/null
> +++ b/lib/kfuzztest/main.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KFuzzTest core module initialization and debugfs interface.
> + *
> + * Copyright 2025 Google LLC
> + */
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/kfuzztest.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ethan Graham <ethangraham@google.com>");
> +MODULE_DESCRIPTION("Kernel Fuzz Testing Framework (KFuzzTest)");
> +
> +extern const struct kfuzztest_target __kfuzztest_targets_start[];
> +extern const struct kfuzztest_target __kfuzztest_targets_end[];
> +
> +/**
> + * struct kfuzztest_dentry - A container for a debugfs dentry and its fops.
> + * @dentry: Pointer to the created debugfs dentry.
> + * @fops: The file_operations struct associated with this dentry.
> + *
> + * This simplifies state management by keeping a file's dentry and its
> + * operations bundled together.
> + */
> +struct kfuzztest_dentry {
> +       struct dentry *dentry;
> +       struct file_operations fops;
> +};
> +
> +/**
> + * struct kfuzztest_debugfs_state - Per-test-case debugfs state.
> + * @test_dir: The top-level debugfs directory for a single test case, e.g.,
> + * /sys/kernel/debug/kfuzztest/<test-name>/.
> + * @input_dentry: The state for the "input" file, which is write-only.
> + *
> + * Wraps all debugfs components created for a single test case.
> + */
> +struct kfuzztest_debugfs_state {
> +       struct dentry *target_dir;
> +       struct kfuzztest_dentry input_dentry;
> +};
> +
> +/**
> + * struct kfuzztest_simple_fuzzer_state - Global state for the KFTF module.
> + * @kfuzztest_dir: The root debugfs directory, /sys/kernel/debug/kfuzztest/.
> + * @debugfs_state: A statically sized array holding the state for each
> + *     registered test case.
> + */
> +struct kfuzztest_state {
> +       struct file_operations fops;
> +       struct dentry *kfuzztest_dir;
> +       struct kfuzztest_debugfs_state *debugfs_state;
> +};
> +
> +/* Global static variable to hold all state for the module. */
> +static struct kfuzztest_state state;
> +
> +const umode_t KFUZZTEST_INPUT_PERMS = 0222;
> +
> +/**
> + * kfuzztest_init - Initializes the debug filesystem for KFuzzTest.
> + *
> + * Each registered test in the ".kfuzztest" section gets its own subdirectory
> + * under "/sys/kernel/debug/kfuzztest/<test-name>" with one files:
> + *     - input: write-only file to send input to the fuzz driver
> + *
> + * Returns:
> + *     0 on success.
> + *     -ENODEV or other error codes if debugfs creation fails.
> + */
> +static int __init kfuzztest_init(void)
> +{
> +       const struct kfuzztest_target *targ;
> +       int ret = 0;
> +       int i = 0;
> +       size_t num_test_cases;
> +
> +       num_test_cases = __kfuzztest_targets_end - __kfuzztest_targets_start;
> +
> +       state.debugfs_state =
> +               kzalloc(num_test_cases * sizeof(struct kfuzztest_debugfs_state),
> +                       GFP_KERNEL);
> +       if (!state.debugfs_state)
> +               return -ENOMEM;
> +
> +       /* Create the main "kfuzztest" directory in /sys/kernel/debug. */
> +       state.kfuzztest_dir = debugfs_create_dir("kfuzztest", NULL);
> +       if (!state.kfuzztest_dir) {
> +               pr_warn("KFuzzTest: could not create debugfs");
> +               return -ENODEV;
> +       }
> +
> +       if (IS_ERR(state.kfuzztest_dir)) {
> +               state.kfuzztest_dir = NULL;
> +               return PTR_ERR(state.kfuzztest_dir);
> +       }
> +
> +       for (targ = __kfuzztest_targets_start; targ < __kfuzztest_targets_end;
> +            targ++, i++) {
> +               /* Create debugfs directory for the target. */
> +               state.debugfs_state[i].target_dir =
> +                       debugfs_create_dir(targ->name, state.kfuzztest_dir);
> +
> +               if (!state.debugfs_state[i].target_dir) {
> +                       ret = -ENOMEM;
> +                       goto cleanup_failure;
> +               } else if (IS_ERR(state.debugfs_state[i].target_dir)) {
> +                       ret = PTR_ERR(state.debugfs_state[i].target_dir);
> +                       goto cleanup_failure;
> +               }
> +
> +               /* Create an input file under the target's directory. */
> +               state.debugfs_state[i].input_dentry.fops =
> +                       (struct file_operations){
> +                               .owner = THIS_MODULE,
> +                               .write = targ->write_input_cb,
> +                       };
> +               state.debugfs_state[i].input_dentry.dentry =
> +                       debugfs_create_file(
> +                               "input", KFUZZTEST_INPUT_PERMS,
> +                               state.debugfs_state[i].target_dir, NULL,
> +                               &state.debugfs_state[i].input_dentry.fops);
> +               if (!state.debugfs_state[i].input_dentry.dentry) {
> +                       ret = -ENOMEM;
> +                       goto cleanup_failure;
> +               } else if (IS_ERR(state.debugfs_state[i].input_dentry.dentry)) {
> +                       ret = PTR_ERR(
> +                               state.debugfs_state[i].input_dentry.dentry);
> +                       goto cleanup_failure;
> +               }
> +
> +               pr_info("KFuzzTest: registered target %s", targ->name);
> +       }
> +
> +       return 0;
> +
> +cleanup_failure:
> +       debugfs_remove_recursive(state.kfuzztest_dir);
> +       return ret;
> +}
> +
> +static void __exit kfuzztest_exit(void)
> +{
> +       pr_info("KFuzzTest: exiting");
> +       if (!state.kfuzztest_dir)
> +               return;
> +
> +       debugfs_remove_recursive(state.kfuzztest_dir);
> +       state.kfuzztest_dir = NULL;
> +
> +       if (state.debugfs_state) {
> +               kfree(state.debugfs_state);
> +               state.debugfs_state = NULL;
> +       }
> +}
> +
> +module_init(kfuzztest_init);
> +module_exit(kfuzztest_exit);
> diff --git a/lib/kfuzztest/parse.c b/lib/kfuzztest/parse.c
> new file mode 100644
> index 000000000000..6010171190ad
> --- /dev/null
> +++ b/lib/kfuzztest/parse.c
> @@ -0,0 +1,208 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KFuzzTest input parsing and validation.
> + *
> + * Copyright 2025 Google LLC
> + */
> +#include <linux/kfuzztest.h>
> +#include <linux/kasan.h>
> +
> +/*
> + * Enforce a fixed struct size to ensure a consistent stride when iterating over
> + * the array of these structs in the dedicated ELF section.
> + */
> +static_assert(sizeof(struct kfuzztest_target) == 32, "struct kfuzztest_target should have size 32");
> +static_assert(sizeof(struct kfuzztest_constraint) == 64, "struct kfuzztest_constraint should have size 64");
> +static_assert(sizeof(struct kfuzztest_annotation) == 32, "struct kfuzztest_annotation should have size 32");
> +
> +static int kfuzztest_relocate_v0(struct reloc_region_array *regions, struct reloc_table *rt, void *payload_start,
> +                                void *payload_end)
> +{
> +       struct reloc_region reg, src, dst;
> +       void *poison_start, *poison_end;
> +       uintptr_t *ptr_location;
> +       struct reloc_entry re;
> +       size_t i;
> +
> +       /* Patch pointers. */
> +       for (i = 0; i < rt->num_entries; i++) {
> +               re = rt->entries[i];
> +               src = regions->regions[re.region_id];
> +               ptr_location = (uintptr_t *)((char *)payload_start + src.offset + re.region_offset);
> +               if (re.value == KFUZZTEST_REGIONID_NULL)
> +                       *ptr_location = (uintptr_t)NULL;
> +               else if (re.value < regions->num_regions) {
> +                       dst = regions->regions[re.value];
> +                       *ptr_location = (uintptr_t)((char *)payload_start + dst.offset);
> +               } else
> +                       return -EINVAL;
> +       }
> +
> +       /* Poison the padding between regions. */
> +       for (i = 0; i < regions->num_regions; i++) {
> +               reg = regions->regions[i];
> +
> +               /* Points to the beginning of the inter-region padding */
> +               poison_start = payload_start + reg.offset + reg.size;
> +               if (i < regions->num_regions - 1)
> +                       poison_end = payload_start + regions->regions[i + 1].offset;
> +               else
> +                       poison_end = payload_end;
> +
> +               if ((char *)poison_end > (char *)payload_end)
> +                       return -EINVAL;
> +
> +               kasan_poison_range(poison_start, poison_end - poison_start);
> +       }
> +
> +       /* Poison the padded area preceding the payload. */
> +       kasan_poison_range((char *)payload_start - rt->padding_size, rt->padding_size);
> +       return 0;
> +}
> +
> +static bool kfuzztest_input_is_valid(struct reloc_region_array *regions, struct reloc_table *rt, void *payload_start,
> +                                    void *payload_end)
> +{
> +       size_t payload_size = (char *)payload_end - (char *)payload_start;
> +       struct reloc_region reg, next_reg;
> +       size_t usable_payload_size;
> +       uint32_t region_end_offset;
> +       struct reloc_entry reloc;
> +       uint32_t i;
> +
> +       if ((char *)payload_start > (char *)payload_end)
> +               return false;
> +       if (payload_size < KFUZZTEST_POISON_SIZE)
> +               return false;
> +       usable_payload_size = payload_size - KFUZZTEST_POISON_SIZE;
> +
> +       for (i = 0; i < regions->num_regions; i++) {
> +               reg = regions->regions[i];
> +               if (check_add_overflow(reg.offset, reg.size, &region_end_offset))
> +                       return false;
> +               if ((size_t)region_end_offset > usable_payload_size)
> +                       return false;
> +
> +               if (i < regions->num_regions - 1) {
> +                       next_reg = regions->regions[i + 1];
> +                       if (reg.offset > next_reg.offset)
> +                               return false;
> +                       /*
> +                        * Enforce the minimum poisonable gap between
> +                        * consecutive regions.
> +                        */
> +                       if (reg.offset + reg.size + KFUZZTEST_POISON_SIZE > next_reg.offset)
> +                               return false;
> +               }
> +       }
> +
> +       if (rt->padding_size < KFUZZTEST_POISON_SIZE) {
> +               pr_info("validation failed because rt->padding_size = %u", rt->padding_size);
> +               return false;
> +       }
> +
> +       for (i = 0; i < rt->num_entries; i++) {
> +               reloc = rt->entries[i];
> +               if (reloc.region_id >= regions->num_regions)
> +                       return false;
> +               if (reloc.value != KFUZZTEST_REGIONID_NULL && reloc.value >= regions->num_regions)
> +                       return false;
> +
> +               reg = regions->regions[reloc.region_id];
> +               if (reloc.region_offset % (sizeof(uintptr_t)) || reloc.region_offset + sizeof(uintptr_t) > reg.size)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static int kfuzztest_parse_input_v0(void *input, size_t input_size, struct reloc_region_array **ret_regions,
> +                                   struct reloc_table **ret_reloc_table, void **ret_payload_start,
> +                                   void **ret_payload_end)
> +{
> +       size_t reloc_entries_size, reloc_regions_size;
> +       size_t reloc_table_size, regions_size;
> +       struct reloc_region_array *regions;
> +       void *payload_end, *payload_start;
> +       struct reloc_table *rt;
> +       size_t curr_offset = 0;
> +
> +       if (input_size < sizeof(struct reloc_region_array) + sizeof(struct reloc_table))
> +               return -EINVAL;
> +
> +       regions = input;
> +       if (check_mul_overflow(regions->num_regions, sizeof(struct reloc_region), &reloc_regions_size))
> +               return -EINVAL;
> +       if (check_add_overflow(sizeof(*regions), reloc_regions_size, &regions_size))
> +               return -EINVAL;
> +
> +       curr_offset = regions_size;
> +       if (curr_offset > input_size)
> +               return -EINVAL;
> +       if (input_size - curr_offset < sizeof(struct reloc_table))
> +               return -EINVAL;
> +
> +       rt = (struct reloc_table *)((char *)input + curr_offset);
> +
> +       if (check_mul_overflow((size_t)rt->num_entries, sizeof(struct reloc_entry), &reloc_entries_size))
> +               return -EINVAL;
> +       if (check_add_overflow(sizeof(*rt), reloc_entries_size, &reloc_table_size))
> +               return -EINVAL;
> +       if (check_add_overflow(reloc_table_size, rt->padding_size, &reloc_table_size))
> +               return -EINVAL;
> +
> +       if (check_add_overflow(curr_offset, reloc_table_size, &curr_offset))
> +               return -EINVAL;
> +       if (curr_offset > input_size)
> +               return -EINVAL;
> +
> +       payload_start = (char *)input + curr_offset;
> +       payload_end = (char *)input + input_size;
> +
> +       if (!kfuzztest_input_is_valid(regions, rt, payload_start, payload_end))
> +               return -EINVAL;
> +
> +       *ret_regions = regions;
> +       *ret_reloc_table = rt;
> +       *ret_payload_start = payload_start;
> +       *ret_payload_end = payload_end;
> +       return 0;
> +}
> +
> +static int kfuzztest_parse_and_relocate_v0(void *input, size_t input_size, void **arg_ret)
> +{
> +       struct reloc_region_array *regions;
> +       void *payload_start, *payload_end;
> +       struct reloc_table *reloc_table;
> +       int ret;
> +
> +       ret = kfuzztest_parse_input_v0(input, input_size, &regions, &reloc_table, &payload_start, &payload_end);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = kfuzztest_relocate_v0(regions, reloc_table, payload_start, payload_end);
> +       if (ret < 0)
> +               return ret;
> +       *arg_ret = payload_start;
> +       return 0;
> +}
> +
> +int kfuzztest_parse_and_relocate(void *input, size_t input_size, void **arg_ret)
> +{
> +       u32 version, magic;
> +
> +       if (input_size < sizeof(u32) + sizeof(u32))
> +               return -EINVAL;
> +
> +       magic = *(u32 *)input;
> +       if (magic != KFUZZTEST_HEADER_MAGIC)
> +               return -EINVAL;
> +
> +       version = *(u32 *)((char *)input + sizeof(u32));
> +       switch (version) {
> +       case KFUZZTEST_V0:
> +               return kfuzztest_parse_and_relocate_v0(input + sizeof(u64), input_size - sizeof(u64), arg_ret);
> +       }
> +
> +       return -EINVAL;
> +}
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

--000000000000d384a8063cf067c5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAFFwOy5zrkc9g75Fk3jHNEw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTA2MDEwODEx
MTdaFw0yNTExMjgwODExMTdaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqxNhYGgWa19wqmZKM9x36vX1Yeody+Yaf
r0MV27/mVFHsaMmnN5CpyyGgxplvPa4qPwrBj+5kp3o7syLcqCX0s8cUb24uZ/k1hPhDdkkLbb9+
2Tplkji3loSQxuBhbxlMC75AhqT+sDo8iEX7F4BZW76cQBvDLyRr/7VG5BrviT5zFsfi0N62WlXj
XMaUjt0G6uloszFPOWkl6GBRRVOwgLAcggqUjKiLjFGcQB5GuyDPFPyTR0uQvg8zwSOph7TNTb/F
jyics8WBCAj6iSmMX96uJ3Q7sdtW3TWUVDkHXB3Mk+9E2P2mRw3mS5q0VhNLQpFrox4/gXbgvsji
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgFacMd25Haozy8Dbg6EJAtvfsW9wo
SnPlSrB25d/HNGMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODIyMDg1ODExWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAc1yOwJQc/F49KkfD/RGR6+pgJDNaVi966norWXgjpAbryQNYssi5Uvv42jag9zFV
4k86oHmG9jItTPZpIPhv4W5zFVN1pUmPik1/xZENW65BCDV4EoRQujvLowM4DaQJqjZ3+PQdQ0us
I8gFBN1Voo7xLZOhkzCpVsctVVjeqTJl1k/wQlmaURNaZlYo9XzIle8CPBgyxAQWK70LF4UZSit9
tCeV8hjmu0ePdHhNQwbh69Bg88fjwnKxYW1vz83UBs6+xt+z5GYjQfASs3GQGaWK8o4mg4XK70SS
bEr23jTnj9sDYxq4EUlC2d5q9BRI9YITrSnMqbtI3CteYWM0Gg==
--000000000000d384a8063cf067c5--

