Return-Path: <linux-kernel+bounces-890430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DADBC40091
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D36B3BA4E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C582D1319;
	Fri,  7 Nov 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL9cy0/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC52BDC34
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520877; cv=none; b=ONwrcU288OjjG1mfhXe2PxXgElZSnOFVDxY6IMLkaLUiJMXTT83FEXcO3Ehn4bGAEYbb4C+bOdA6k2E9ZrlY8yuYISRTj/su6HGVUJDo8x6aqZ74U3iogyWqFfvVUtE5m61yBjzeD5VJulYgDb8Bseg3sDnB7SAFYEzjG3sgdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520877; c=relaxed/simple;
	bh=HF3so+PDtP59y2oejyEjViinp3zdIxJ+DfAN5qy7mxM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jKzS/OYnDeMm9SIi+FUSp/iBr2wn1RMpu75OWATcaxVQRGkONw/eC1QcHJZ4kjefly4OL7Cyqs1KcNN+Cb0bINKNd77aiUAF9zKIPBwaoQypXO2ZlG+UIM4ZeLgXMCEHsOGDAYVeDLE9uyVmo/0XqRPhqvo2OD2P9mC4e71xxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL9cy0/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B69C19422;
	Fri,  7 Nov 2025 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762520876;
	bh=HF3so+PDtP59y2oejyEjViinp3zdIxJ+DfAN5qy7mxM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=lL9cy0/4VKkmYNj/eNTlSwqT8MlQb94nOk9CB1ypflDgvIzZv4hbwudjTvp/djFBw
	 rOg/7Y3HQe34zg/kcVc/hZ3FP7gFKdHBtIbEKP0AI8QezQ83IUnGSUz11FZftiWdnt
	 cmX/EO5ucjscDfQFz9s5lSkJLeV6zCBLl3kFc0yB3DENpm4jdo7Zj/CRMI81BgH6Ou
	 btCTR47ldXuyooQzh3TwCuBIOaIBH4tCNq1H4Cj1cupEjqbRU+EolaPG03yZW6KPeC
	 HCCS3AMaK0oit9Z/FLaojSo1VgBkyJ07llmihKE/+DGmns3ZS4jWtfOkqN5H4BDIBh
	 BaUzVUpKfWPCw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vHMC6-00000000GGz-13ie;
	Fri, 07 Nov 2025 08:07:58 -0500
Message-ID: <20251107130758.106460323@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 07 Nov 2025 08:07:32 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Zilin Guan <zilin@seu.edu.cn>
Subject: [for-linus][PATCH 2/3] tracing: Fix memory leaks in create_field_var()
References: <20251107130730.158197641@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Zilin Guan <zilin@seu.edu.cn>

The function create_field_var() allocates memory for 'val' through
create_hist_field() inside parse_atom(), and for 'var' through
create_var(), which in turn allocates var->type and var->var.name
internally. Simply calling kfree() to release these structures will
result in memory leaks.

Use destroy_hist_field() to properly free 'val', and explicitly release
the memory of var->type and var->var.name before freeing 'var' itself.

Link: https://patch.msgid.link/20251106120132.3639920-1-zilin@seu.edu.cn
Fixes: 02205a6752f22 ("tracing: Add support for 'field variables'")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1d536219b624..6bfaf1210dd2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3272,14 +3272,16 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 	var = create_var(hist_data, file, field_name, val->size, val->type);
 	if (IS_ERR(var)) {
 		hist_err(tr, HIST_ERR_VAR_CREATE_FIND_FAIL, errpos(field_name));
-		kfree(val);
+		destroy_hist_field(val, 0);
 		ret = PTR_ERR(var);
 		goto err;
 	}
 
 	field_var = kzalloc(sizeof(struct field_var), GFP_KERNEL);
 	if (!field_var) {
-		kfree(val);
+		destroy_hist_field(val, 0);
+		kfree_const(var->type);
+		kfree(var->var.name);
 		kfree(var);
 		ret =  -ENOMEM;
 		goto err;
-- 
2.51.0



