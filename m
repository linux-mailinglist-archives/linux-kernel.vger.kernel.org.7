Return-Path: <linux-kernel+bounces-821587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD54B81B17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9CD17D9D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C402242D8B;
	Wed, 17 Sep 2025 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVi1v1VH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AF34BA28
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139093; cv=none; b=eElu1LXTC/haAtQxjbjfF9JzQH5j2V3YIoDRKehzJ3tDkVpzbMDOaMhvQMBcQYs93+HAY6GtBpwNtmZvXEQIUo7EJ1aXzh1DjEkZUXY1lMFvyTtB6HMaOTJaXGrDxRmCHzUkblMZsN66ylD2ktw0cL+DFQ0CoM0aRFzLAwsyWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139093; c=relaxed/simple;
	bh=VYhOCC8w8b0du4gtXNNKjrAafCOFYDdyrDStA8xhIEQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QhNMN3VCXM5+jwpOsbpWrZmBiVSR8Vd3DYKLogHsKJV1bcCNd4KtSCV0dDolIDcRkKDhUqxKh9My6qLqSxtWaQuZJu+501C7LVAkFZkC7eE+N5C0BgyHDa2443H1zbqq8P+siK6RhXi/1iVESyYUrAD7ykOcbzSn372N8d3E2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVi1v1VH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ea5d0f85d77so134207276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139091; x=1758743891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jKpyAd31LStv7r9U6TzGp8PoM20m6pKTZ/PYA4rOye4=;
        b=qVi1v1VHfErUu1lA/8E/3HnyRqsBug2NEIbCVf0TCjgCVNRME3cXuVWZU7I+di7utw
         K/b3bku48fRS2ELschFl7PX0num00xNRwQab3YEzjpHBsOa/tfphO34V/WaiYXLMgXdu
         I+PcIfMbeLcr1Cq/y6gyE6FMLMuo/xf8QGzs3aPTH8MsCc8vHr7lC+1HedG9ABxgVHqy
         tsnu1dCUViBQuD5eDZ+i1HbZoe7gxT7AVKnpGZgx/bydferA71AhzDl2uNkacqYmFTHd
         EPQcFLRlh0dCHfYizLS83P66XtMbgQdHM35M1wf1lxkG2sodm1gUfk8fJ+JrKoOVlYdc
         dVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139091; x=1758743891;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKpyAd31LStv7r9U6TzGp8PoM20m6pKTZ/PYA4rOye4=;
        b=QU/dDYdI+yapg5OnVbmvItrYn33WE3x2yCJ51WDGUje1KA02asAqynCGrgRL+vKoI2
         Rg5f3pI9Yn0vOXCXsWuLct+S7yf8rUXak4bOf5Nph5eGEeUZtGJZUnEcYflu8mn70c3K
         znbEVGxW8J5kf96HqOTgTBZCYxVudagK+oT5BGl+CljF+Oogt0V7tTcqpyjdjLb+wfzZ
         3MlJ7KHwbFxnoaxlFCMC3blha8vZnlls5GSXspIg1TiyogCVt931kjr1xJEghZZil7x9
         W54d6pkJjp/aGZHrPV/HxAzoOr2T6jWF0BF64mBftmhWbbnxde2psYEZWeVGtbRzdVi2
         kYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZmm/B42BMylJQHOIAd02PKEyrLnyknSlYsobvZiEUD5wytPNppXCRq/A944PSFA6PJRDZBkKJCmUcbqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VGA/XEMlVJm694DaEhVf3q0iSgVb7ob8x2BwE7KBtfUPNVDP
	TgTuYp3RQ1PO9djHTFFwP8/7nqBDjtHcSO7Qn3hnEJYQx0ru8FA05n9H8yOAoDV5o8rGmiICXTo
	MRveB3gDrZQ==
X-Google-Smtp-Source: AGHT+IGOGjX3+rWe9h1zahrKmHzEVszha+4XSttUZLk4M8GG2BxNj1YYXRyNn1PdDObKnf+2TxvmgACchUO6
X-Received: from ybbha6.prod.google.com ([2002:a05:6902:4506:b0:ea3:ef8e:1987])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:1b8d:b0:e9b:afa3:518e
 with SMTP id 3f1490d57ef6-ea5c04463b1mr3090328276.32.1758139090906; Wed, 17
 Sep 2025 12:58:10 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:57:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-1-zecheng@google.com>
Subject: [PATCH v3 00/10] perf tools: Some improvements on data type profiler
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've identified several missing data type annotations within the perf
tools when annotating the Linux kernel. This patch series improves the
coverage and correctness of data type annotations.

Some patches from the previous version of this series were
cherry-picked. This revision adds new improvements based on feedback and
further development.

Here's a breakdown of the changes in this revision:

Patch 1 skips annotations for LEA instructions in x86, as these do not
involve memory access. It now returns NO_TYPE.

Patches 2-3 implement the TSR_KIND_POINTER to represent registers
holding memory addresses of the type. Two points here may need more
discussion:

- When moving a TSR_KIND_POINTER to the stack in set_stack_state, how
should we obtain the pointer size for the target arch?

- If the target instruction is a stack memory access and the stack state
is TSR_KIND_POINTER, we should find or compose a pointer type to
state->type. How should this be implemented?

Patches 4-6 implement a basic approach for register offset tracking that
supports add, sub, and lea operations. The register state is invalidated
when an unsupported arithmetic instruction is encountered. This revision
uses TSR_KIND_POINTER to avoid finding the pointer type in DWARF and
preserves the pointer offset information in the stack state.

One question is what type should we use for the pointer + offset case.
For example, if an offset of 128 is added to a struct rq * pointer, it
then points to &rq->cfs_rq. Should we try to find the pointer type for
cfs_rq or just use the original pointer type (rq *)? It is currently
implemented to use the original pointer type.

Patches 7-9 split patch 8 from v2 with some minor improvements. It skips
check_variable when the type is found directly by register, since
sufficient checking is already performed in match_var_offset.
check_variable lacks some DWARF information to correctly determine if a
variable is valid. I also found it is able to find members for
typedef'd types so I preserve them in match_var_offset.

Patch 10 implements support for DW_OP_piece. Currently, this is allowed
in check_allowed_ops but is handled like other single location
expressions. This patch splits any expression containing DW_OP_piece
into multiple parts and handle them separately.

I have tested each patch on a vmlinux and manually checked the results.
After applying all patches, there are less missing or incorrect
annotations. No obvious regressions were observed.

v3:
Already cherry-picked patches in v2:

perf dwarf-aux: Use signed variable types in match_var_offset
perf dwarf-aux: More accurate variable type match for breg
perf dwarf-aux: Better variable collection for insn tracking
perf dwarf-aux: Skip check_variable for die_find_variable_by_reg

v2:
https://lore.kernel.org/all/20250825195412.223077-1-zecheng@google.com/
1. update the match_var_offset function signature to s64
2. correct the comment for is_breg_access_indirect. Use simpler logic to
match the expressions we support.
3. add is_reg_var_addr to indicate whether a register holds an address
of the variable. This defers the type dereference logic to
update_var_state.
4. invalidate register state for unsupported instructions.
5. include two new patches related to improving data type profiler.

v1:
https://lore.kernel.org/linux-perf-users/20250725202809.1230085-1-zecheng@google.com/


Zecheng Li (10):
  perf annotate: Skip annotating data types to lea instructions
  perf annotate: Rename TSR_KIND_POINTER to TSR_KIND_PERCPU_POINTER
  perf annotate: Track address registers via TSR_KIND_POINTER
  perf annotate: Track arithmetic instructions on pointers
  perf annotate: Save pointer offset in stack state
  perf annotate: Invalidate register states for untracked instructions
  perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
  perf dwarf-aux: Preserve typedefs in match_var_offset
  perf annotate: Improve type comparison from different scopes
  perf dwarf-aux: Support DW_OP_piece expressions

 tools/perf/arch/x86/annotate/instructions.c | 175 ++++++++++++-
 tools/perf/util/annotate-data.c             |  93 +++++--
 tools/perf/util/annotate-data.h             |  14 +-
 tools/perf/util/annotate.c                  |  19 ++
 tools/perf/util/dwarf-aux.c                 | 266 +++++++++++++++-----
 tools/perf/util/dwarf-aux.h                 |   2 +-
 6 files changed, 474 insertions(+), 95 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


