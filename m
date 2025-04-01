Return-Path: <linux-kernel+bounces-583979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EE8A7821D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833D01699DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4382116FA;
	Tue,  1 Apr 2025 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+ofP6MR"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942221D3D2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531902; cv=none; b=uKgY4vwTrmsYViha9d4HNB3WQVJUyULy1JvfFT+q3RbLXxUj7qF36EXnH68H4H2HFhkgcODfdRAdI8bnHXE+I/eea45eIxpn77qNLXexAG2/B3kVjHrrPRdos8CUamnWUM7USyg6sSQGQsdaj8ebJ9LFbbxEVyYOoaJxY4zzqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531902; c=relaxed/simple;
	bh=G1beShr2OJE3B99IVVRLG7JvNtyE0vRd7w9ReDXBJPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cRmCDWA92C10aRY9AATsp6EBHJmuj5UiBUUeW3hjNksLj38+ZWaX2GaDUv8Ob8//MLrni7brl6ppSh+2jIQw0+8kqcrNlT3QnA+hy6qNszhC6TXWQEs6M4zV+VbGYemDUK0zDiEjso83amb8zfzqAvii2S/AmBxsn1CKjQj8wYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+ofP6MR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso10929924a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531899; x=1744136699; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyvB/hrRudd3aX9cJ1p0ixiv1zuMhB3nN0i+ysTn1DI=;
        b=m+ofP6MRgfMxiChrBfeWbzDsNgYFkZvhVkKbEQ4M/+yZfml7Bhxg40y+sllyTIXUFO
         OYPLxjdkSfy39vefCO9CRSHd9aBO03tmUV79iQyCwKvZweHs/1yCL65l6zwk1oyJw1AT
         PNzqkBM1Y+K4xjy0qXE3qNK9nioSgrblytWYpF43Os2NN5ocBAv58KC2Cbe/Z8EYEwxO
         utOncuPB9M8F1wexYeSeD3tH8RJS/2vWeLp8/CrSnAlFqoDWkOGynxyldcxxBC8aknfZ
         OKrfGzhEggF4jj2EXGYwpBIm9jILd00bdO42U2b6btGP/jtu8jAVzZvKSIorq3uajDti
         whbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531899; x=1744136699;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyvB/hrRudd3aX9cJ1p0ixiv1zuMhB3nN0i+ysTn1DI=;
        b=KSjygVVcl4GeOFFyn7Op+o+Py3iXIlUKfrmIYuBLWTDH8HFCf4GUbjyp9np1z4J2eR
         mdpFu5ZBhPC3cQrOBIfGGlTMd0FEnc5Hj0J4WQhxGUR2wT7MjwNcer+WZHkvLau1VKCV
         TEtO+6rSskFWUHZIutwXMyvjfj1+SxuWYPjmPuQSjU4ij3NHfMMgNWveQMtt62j/pVn1
         hIcHkHsLrG8kk87m6yTHljIprMtRlqFbrACXuDhf0O20jDlHef2pyVcpSZW+bXAXFNoW
         FoSrZDXc6BRgz1WgEXuKpSoGEnDIso+G1xWcTWtF1pPRN3O2w4S0biAOguI9t9updMQy
         rk2g==
X-Forwarded-Encrypted: i=1; AJvYcCVw9Rn3kFZEIWlnSCfiKIjWyuJ0duhWFJW5Y8SnA1MGVUMGnPfHrDdgRLuVaanCCZMhtpm4Bu3llD3k1uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziW3N5cgG7bj5MVBfKeG3bevxK1kD443FpktxSxnjkdY6o79b0
	jTn43YGEFP4LqxaTC/E6AlaVaIN/JUa+aWSyy+2u6f2Mfmf13fyQm28DBKeK0OpmQO6Fr3dBnBF
	b0p1a7Q==
X-Google-Smtp-Source: AGHT+IFqNyoO9wg1AcwskU/SqQSwLTGoj2ZZZrlovJNkz+5uOGhYMYbqeQpgsHNNLM6uCXnMYqikFnYyzlT6
X-Received: from pfbmc41.prod.google.com ([2002:a05:6a00:76a9:b0:736:4313:e6bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1701:b0:736:a8db:93bb
 with SMTP id d2e1a72fcca58-7398034e617mr15291484b3a.5.1743531899092; Tue, 01
 Apr 2025 11:24:59 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:09 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-12-irogers@google.com>
Subject: [PATCH v1 11/48] perf arm-spe: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  4 ++--
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     |  2 +-
 tools/perf/util/arm-spe.c                     | 24 +++++++++----------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 688fe6d75244..58107970b215 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -117,7 +117,7 @@ static int arm_spe_get_data(struct arm_spe_decoder *decoder)
 	if (!decoder->len)
 		pr_debug("No more data\n");
 
-	return decoder->len;
+	return (int)decoder->len;
 }
 
 static int arm_spe_get_next_packet(struct arm_spe_decoder *decoder)
@@ -187,7 +187,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			break;
 		case ARM_SPE_COUNTER:
 			if (idx == SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT)
-				decoder->record.latency = payload;
+				decoder->record.latency = (u32)payload;
 			break;
 		case ARM_SPE_CONTEXT:
 			decoder->record.context_id = payload;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 13cadb2f1cea..a6d04ad50db6 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -63,7 +63,7 @@ static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 	default: return ARM_SPE_BAD_PACKET;
 	}
 
-	return 1 + ext_hdr + payload_len;
+	return 1 + ext_hdr + (int)payload_len;
 }
 
 static int arm_spe_get_pad(struct arm_spe_pkt *packet)
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2a9775649cc2..561bef7b4628 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -786,7 +786,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 	}
 
 	for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
-		if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
+		if (is_midr_in_range_list((u32)midr, data_source_handles[i].midr_ranges)) {
 			data_source_handles[i].ds_synth(record, data_src);
 			return true;
 		}
@@ -956,7 +956,7 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 		 */
 		record = &speq->decoder->record;
 		if (!spe->timeless_decoding && record->context_id != (u64)-1) {
-			ret = arm_spe_set_tid(speq, record->context_id);
+			ret = arm_spe_set_tid(speq, (pid_t)record->context_id);
 			if (ret)
 				return ret;
 
@@ -1344,8 +1344,8 @@ static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
 	}
 
 	*ver = ptr[ARM_SPE_HEADER_VERSION];
-	hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
-	*nr_cpu = ptr[ARM_SPE_CPUS_NUM];
+	hdr_sz = (int)ptr[ARM_SPE_HEADER_SIZE];
+	*nr_cpu = (int)ptr[ARM_SPE_CPUS_NUM];
 
 	metadata = calloc(*nr_cpu, sizeof(*metadata));
 	if (!metadata)
@@ -1353,7 +1353,7 @@ static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
 
 	/* Locate the start address of per CPU metadata */
 	ptr += hdr_sz;
-	per_cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
+	per_cpu_sz = (int)((metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu));
 
 	for (i = 0; i < *nr_cpu; i++) {
 		metadata[i] = arm_spe__alloc_per_cpu_metadata(ptr, per_cpu_sz);
@@ -1405,7 +1405,7 @@ static void arm_spe_free(struct perf_session *session)
 	auxtrace_heap__free(&spe->heap);
 	arm_spe_free_events(session);
 	session->auxtrace = NULL;
-	arm_spe__free_metadata(spe->metadata, spe->metadata_nr_cpu);
+	arm_spe__free_metadata(spe->metadata, (int)spe->metadata_nr_cpu);
 	free(spe);
 }
 
@@ -1451,8 +1451,8 @@ static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
 		hdr_size = ARM_SPE_AUXTRACE_V1_PRIV_MAX;
 		hdr_fmts = metadata_hdr_v1_fmts;
 	} else {
-		cpu_num = arr[ARM_SPE_CPUS_NUM];
-		hdr_size = arr[ARM_SPE_HEADER_SIZE];
+		cpu_num = (unsigned int)arr[ARM_SPE_CPUS_NUM];
+		hdr_size = (unsigned int)arr[ARM_SPE_HEADER_SIZE];
 		hdr_fmts = metadata_hdr_fmts;
 	}
 
@@ -1466,7 +1466,7 @@ static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
 		 * are fixed. The sequential parameter size is decided by the
 		 * field 'ARM_SPE_CPU_NR_PARAMS'.
 		 */
-		cpu_size = (ARM_SPE_CPU_NR_PARAMS + 1) + arr[ARM_SPE_CPU_NR_PARAMS];
+		cpu_size = (unsigned int)((ARM_SPE_CPU_NR_PARAMS + 1) + arr[ARM_SPE_CPU_NR_PARAMS]);
 		for (i = 0; i < cpu_size; i++)
 			fprintf(stdout, metadata_per_cpu_fmts[i], arr[i]);
 		arr += cpu_size;
@@ -1731,9 +1731,9 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
 	if (metadata_ver == 1)
-		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+		spe->pmu_type = (u32)auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 	else
-		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE_V2];
+		spe->pmu_type = (u32)auxtrace_info->priv[ARM_SPE_PMU_TYPE_V2];
 	spe->metadata = metadata;
 	spe->metadata_ver = metadata_ver;
 	spe->metadata_nr_cpu = nr_cpu;
@@ -1752,7 +1752,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	 * "time_cycles" only if they are contained in the event.
 	 */
 	spe->tc.time_shift = tc->time_shift;
-	spe->tc.time_mult = tc->time_mult;
+	spe->tc.time_mult = (u32)tc->time_mult;
 	spe->tc.time_zero = tc->time_zero;
 
 	if (event_contains(*tc, time_cycles)) {
-- 
2.49.0.504.g3bcea36a83-goog


