Return-Path: <linux-kernel+bounces-888521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCCCC3B0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7639B188ED22
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B17733C525;
	Thu,  6 Nov 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx+O8LXv"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09714333448
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433623; cv=none; b=RY5TAumLksZeso9ckDQ70l7MTpS8ZVNHfArcC9oDCvTo7ZwFKzsmHHgAxICkqY3Evuwyru5mGUbAWmmwGoLEs43h93zpWDDQVMwVsj+BiBB1h2Roo6Zp4ggUtzbAPlqVovwvhAUQyIyT9M2tO+hXFtSFz3es5bpV4H3EoDQtZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433623; c=relaxed/simple;
	bh=nJMaLGpKEmP3DsyD+IyFFczvrWgzDb+7/77EaIxg+NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2i3vhqgrgZraL43fp68+8mpZV79/gux6alViTiIH0Uirx9n3DXrDL1eKCgSrcYn0LQ1DrDrOep4yFS91+wBv/HP4WPmyhwVBkx1g3YPSv7MF8Fu4CptlfbjStps4FXEHPOqaInfuhP6pR+O26eCvG1AfRKlPiGyestRf0+KrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bx+O8LXv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso657741f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433619; x=1763038419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gboyt37Ov9MOTTH/KPaW8uj5vESoPgNEDU8dO3DpPF0=;
        b=Bx+O8LXvxiiSTcAE6E8Z0YHAr8UcvU4LFsOvQf/bttKd2WtVNM80bh9xYhBuQ7Scoy
         WdIIb5Fa+y/+3p6Hy6T+viHpCkl55dsvdGLw9ZCBA0nI89NiCk3MBGMSR+aGDRIk1+Ic
         hbPgXhSPulZ7VGIAtkFDUX7LRVayoa0gwRiSBazFfpCf5+M2Fx/EkJhBYYTUqM8SrMwK
         0hCGuSS4wnPXikaQob3ZuWDPTFCrXuTvXceP66MxUNadN+3ToqJet1EnIkqJCD3SupQW
         znBNlqMxmQOrqhbEp37Mf0NwSL64nsAgZX4OCyAkrBydRvfpPcuh6tvckDD1qht2HRxt
         6i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433619; x=1763038419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gboyt37Ov9MOTTH/KPaW8uj5vESoPgNEDU8dO3DpPF0=;
        b=RpUVTpyKmYmA+I7FR4UUNMKsFsytfkhycNan4H+259QbNqSiJEqeqQCoGkFyEhJUYi
         KESuuM57aFU8MJxu3MUuoovdD2r/f+nhF+MVZ8KctO187tkX7pj8UJAJJCpStZqcmBgq
         2bEo0gmWKP0aKvJ+i4Mox6Cc8Ag6di5ufIS9SZLDUSlNH67uHDPYguHOSaHaJQjHRXam
         1AS+MVNasUlyU2f98nanqdVOpIXhyOIjT6hjmRCvewl13vpvLcnbMBcf6Cornfj8L+xq
         UegvrkMhROnTqFcLV0LjibokTFQo9CimcyHrh34KXQXjoBGlZ70KQCmt1MSnxT5dRHvW
         nj8g==
X-Forwarded-Encrypted: i=1; AJvYcCXN5tdjG0Htb5QOT+YzXSStSxXl2OjdWExe/VgMb9FMDmR3km2g0KBRtCThOfLuekrKCAFqlMVXULDzBtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8v9oBYF/FN9RJ7i2VQVseb6Hl4IRiRDhXhoea92ZAjr02xIaa
	eAktgt3wuSKIOf45TE22/KJKbYSYDGvyguzK0AOMcn0OHUm/98WKN0w=
X-Gm-Gg: ASbGnctL7I+q/3iNwS3SBAOlazhd/FgV8Aw+sb5KKw0vripzo8MRd3oLZehmwu2Oek5
	p96p4o0IaRBrNtipZldh1nsWf4PYtjDx4dYKvQWtlG6FTNmkAwc5pPoEfwQKlCCupB8VyykDv4H
	CJGs4cvj/jYY/lA1tTtKgmeinQFf/ycLcAqkb7iUXPE6dhMAAlpj/SQgx42jKzNWQAcIqJYm37m
	sTHAVtWxrL8pxxErc0WJOacugy4Jy/A2C5pMEVnqSJSnvWOxLW0ZPNyGipG+lC7nGI5qWBQTEGp
	iLeKspEFuff0Q39iaLVeY/nbZbpHo4eir5GFxN2a1onFVWlQ8klXc4YEGOT0/kaJgapJd1dZAT8
	IcK2k9mQNaZxsAwI4a4EIxRtdumibewzA2VEJkoNZwyTlIeZqVqJzZg6+PiEUZ7ksw0sMv8eSuX
	BpTHuiuB+BH31DcCTzT9cl4EN2h8PcAO+VixoJpysIdOt/BLv79dKElvk=
X-Google-Smtp-Source: AGHT+IE2d3CRUrs2Qxa0+9muOrmRjSuRP78wlr1433ZpQlc/ZIYdsLyGsliVtRU0kPFyTQ8p1N80tw==
X-Received: by 2002:a5d:5f54:0:b0:429:bb77:5deb with SMTP id ffacd0b85a97d-429eb1d0d12mr3086191f8f.31.1762433619310;
        Thu, 06 Nov 2025 04:53:39 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:39 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 06/17] bpf: Add bcf_match_path() to follow the path suffix
Date: Thu,  6 Nov 2025 13:52:44 +0100
Message-Id: <20251106125255.1969938-7-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add `bcf_match_path()` to constrain `bcf_track()` to the recorded path suffix
from parent states. The function consumes the per-state jump history arrays in
order and compares each (prev_idx, idx) pair against the verifier’s current
(prev_insn_idx, insn_idx):

- If the current pair matches the top entry, advance to the next history entry;
  when the last entry is consumed and the last state's last_insn matches, stop
  tracking (PATH_DONE).
- If the pair mismatches at a branch point, abandon the current fork
  (PATH_MISMATCH) so the tracker pops the path.
- Otherwise, continue (PATH_MATCH).

`do_check()` is updated under tracking mode to call `bcf_match_path()` before
processing each instruction and to terminate early on PATH_DONE, ensuring only
suffix instructions are symbolically analyzed.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 725ea503c1c7..3ecee219605f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20082,6 +20082,63 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	return 0;
 }
 
+static struct bpf_jmp_history_entry *
+get_top_jmp_entry(struct bpf_verifier_env *env)
+{
+	struct bcf_refine_state *bcf = &env->bcf;
+	struct bpf_verifier_state *vstate;
+next:
+	if (bcf->cur_vstate >= bcf->vstate_cnt)
+		return NULL;
+	vstate = bcf->parents[bcf->cur_vstate];
+	if (bcf->cur_jmp_entry >= vstate->jmp_history_cnt) {
+		bcf->cur_vstate++;
+		bcf->cur_jmp_entry = 0;
+		goto next;
+	}
+	return &vstate->jmp_history[bcf->cur_jmp_entry];
+}
+
+enum { PATH_MATCH, PATH_MISMATCH, PATH_DONE };
+
+static int bcf_match_path(struct bpf_verifier_env *env)
+{
+	struct bcf_refine_state *bcf = &env->bcf;
+	struct bpf_jmp_history_entry *top = get_top_jmp_entry(env);
+	struct bpf_verifier_state *last_state;
+	int prev_idx;
+
+	last_state = bcf->parents[bcf->vstate_cnt - 1];
+	if (!top)
+		return last_state->last_insn_idx == env->prev_insn_idx ?
+			       PATH_DONE :
+			       PATH_MATCH;
+
+	prev_idx = top->prev_idx;
+	/* entry->prev_idx is u32:20, compiler does not sign extend this */
+	if (prev_idx == 0xfffff)
+		prev_idx = -1;
+
+	if (prev_idx == env->prev_insn_idx) {
+		if (top->idx == env->insn_idx) {
+			bcf->cur_jmp_entry++;
+			/* Check if we have consumed the last entry */
+			top = get_top_jmp_entry(env);
+			if (!top &&
+			    last_state->last_insn_idx == env->prev_insn_idx)
+				return PATH_DONE;
+			return PATH_MATCH;
+		}
+		return PATH_MISMATCH;
+	}
+
+	/* cur_state is branch taken, but the recorded one is not */
+	if (is_jmp_point(env, env->insn_idx))
+		return PATH_MISMATCH;
+
+	return PATH_MATCH;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -20144,6 +20201,15 @@ static int do_check(struct bpf_verifier_env *env)
 				return err;
 		}
 
+		if (env->bcf.tracking) {
+			int path = bcf_match_path(env);
+
+			if (path == PATH_MISMATCH)
+				goto process_bpf_exit;
+			else if (path == PATH_DONE)
+				return 0;
+		}
+
 		if (signal_pending(current))
 			return -EAGAIN;
 
-- 
2.34.1


