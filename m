Return-Path: <linux-kernel+bounces-845934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA73BC6856
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8FC3A459B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE698279327;
	Wed,  8 Oct 2025 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNp8oLD8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16D27877B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953601; cv=none; b=CkBpu9PjF+Lt+0vHRx8xnTqDy0QcXTpCSFp3DBhCKHjHHg0HUixRh3ijaQEZ8sYYgZVsJhLIsUbTbwDqymVtMKDWEuvMDfbfuz9C6sT550Y5Glk8I5znC7ChCFqrxxIuI5cwH4vxlMFTDZNH69eXyWD9dkyEO8BRvCi+OTByqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953601; c=relaxed/simple;
	bh=YxZxGVPgrbcUQf05HaafiT1TjMGPobJaNf5XRQb6JKU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUMOYKstBsuoc6Hz12GnhCaHXI9d3afYpKN40XmbTggvjlhMcpeTOOOaBhcxSTzoJeKSkl7ETCHZyaMDZyUbKabBispKFLWEy+LPlaj3QjSvuhwRlvKjQqXU3inT+a4oIwGnsU4Ekp5OjufHu2cePcT1icTN9gyMevJ5LlXZ0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNp8oLD8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg94taPX5CGEY2YLQCYWgTJzRNpALaMB5K0LUWzUztM=;
	b=VNp8oLD8IsyVE6aIJN5gpx/BOnCXoOjHpwUCCr/fU8dlMY1ZiIFu2h2rDYM9RsnbuLXBBp
	FIsgMixRz0xuc1Is7/nhrDegfl8IkUf89JmBC7V4ZlbNhz+/Lji+yR9aFYlZZzggq7xxxL
	v6G9mCikf/TbzLvFZgniY7lr4/fjkGw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-PrE_mHe7NseyPSNWdqaQDw-1; Wed, 08 Oct 2025 15:59:58 -0400
X-MC-Unique: PrE_mHe7NseyPSNWdqaQDw-1
X-Mimecast-MFC-AGG-ID: PrE_mHe7NseyPSNWdqaQDw_1759953597
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-40fd1b17d2bso125751f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953597; x=1760558397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg94taPX5CGEY2YLQCYWgTJzRNpALaMB5K0LUWzUztM=;
        b=NOwhadcrkFt3o9g4NFAi9scng+JpXN2gwKiSNIc1SpN8M3qOJuC5WueB9pC3dnu57c
         eSGIpfEmVgcZxZKiOs8z1Ll8M+tFyIh7DdbC7cV0fUmAkcKaFWxU2GvzFlLs66pS3+NX
         VkDMKE45KeYt5tI7pn0ADrt24G2uWgeTulcd12HmsvZspxNRkJgLQjQD9jyRiP3MfomU
         nBiNIsNY7nzXb8XNpgEz+On/0cBfM2knnf2xQHqLVmxKVcciMalmbq5YeN3yMgs3vBrd
         8lDTKlDdISJ5Sj4crtOYierMzfaJZj0GDHwfL7gJbpDXtTZ7EVdknyzu1xrcr41zwgFQ
         IF0A==
X-Forwarded-Encrypted: i=1; AJvYcCUwc8yWV0cPFzXRmYQnmGkuGn+J4dQAORbYOLGrNBwGysaliFuUAfjP4c0RZA7SqsNxwlJRA1T1MV6kiTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1APhtl0z3O9yGjN9w3t3DQg98uoAy6OdlIY9YwSKdL0a/h/0b
	db8KIMs1KVCkRB+6MqUjzLkvMDKzEK/u7TT38A4bkH0BOXeZXzwtWnW9uA7VX1vy3q4Yw761V8w
	OdmhpaQjRdJpzfaFY0vjDRwGF374DxibJkqQVGT/mZTHrrF/cl4ttvcDWyUh7u5+Xmg==
X-Gm-Gg: ASbGnctGQzbdD4cAIM5Xnzpj9Jj/Ex/Rv/2GLGeZqrXy2LVXYKW6tiqK8lvAfO1VplU
	YgPPIdex0+s76NTd+TvxN5hfFz9al9elkDGYfhTGOLENj59yMBVlysUm39uPdmT4nDb08Htdo1I
	aMMtMHn0lFtqU5Efusn/eDBVC/ehfr0lzf89yKnu3jxcW66x1K5os2JLhHhSF8/12AVx98/wBFo
	+wzU6QY0h0QILeQDwbWp1WTxprmxfm6ilOcYMTVQRGzYryIU+uh1hg3VD2vv2q1Qjwo2lavunKc
	vthLGZ0wwfg+MeSwx/zpFCUNjEmePXQLQqIYAY9f/2+CmXkyzXGv3PUFtwq9fZQ=
X-Received: by 2002:a05:6000:1862:b0:3e7:492f:72b4 with SMTP id ffacd0b85a97d-4266e7df7f7mr3015746f8f.42.1759953596837;
        Wed, 08 Oct 2025 12:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0dEKdVVbbefPxraYSKbfgy6wGcFkOVkvZ4hpJR6iApWTuCQJvWeYWquxXyKMzAk9ArVEwTQ==
X-Received: by 2002:a05:6000:1862:b0:3e7:492f:72b4 with SMTP id ffacd0b85a97d-4266e7df7f7mr3015729f8f.42.1759953596310;
        Wed, 08 Oct 2025 12:59:56 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:55 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")
Date: Wed,  8 Oct 2025 22:59:04 +0300
Message-ID: <20251008195905.333514-5-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008195905.333514-1-costa.shul@redhat.com>
References: <20251008195905.333514-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A long time ago, when the usage help was short, it was a favor
to the user to show it on error. Now that the usage help has
become very long, it is too noisy to dump the complete help text
for each typo after the error message itself.

Replace osnoise_hist_usage("...") with fatal("...") on errors.

Remove the already unused 'usage' argument from osnoise_hist_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 43c323521f55..3c4d8e25fd55 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -421,7 +421,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 /*
  * osnoise_hist_usage - prints osnoise hist usage message
  */
-static void osnoise_hist_usage(char *usage)
+static void osnoise_hist_usage(void)
 {
 	int i;
 
@@ -467,18 +467,12 @@ static void osnoise_hist_usage(char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	fprintf(stderr, "rtla osnoise hist: a per-cpu histogram of the OS noise (version %s)\n",
 			VERSION);
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -564,12 +558,12 @@ static struct common_params
 			params->common.hist.bucket_size = get_llong_from_str(optarg);
 			if (params->common.hist.bucket_size == 0 ||
 			    params->common.hist.bucket_size >= 1000000)
-				osnoise_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
+				fatal("Bucket size needs to be > 0 and <= 1000000\n");
 			break;
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				osnoise_hist_usage("\nInvalid -c cpu list\n");
+				fatal("\nInvalid -c cpu list\n");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -588,12 +582,12 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				osnoise_hist_usage("Invalid -D duration\n");
+				fatal("Invalid -D duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
-				fatal("Error alloc trace event");
+				fatal("Error alloc trace event\n");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -604,11 +598,11 @@ static struct common_params
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
 			    params->common.hist.entries > 9999999)
-				osnoise_hist_usage("Entries must be > 10 and < 9999999\n");
+				fatal("Entries must be > 10 and < 9999999\n");
 			break;
 		case 'h':
 		case '?':
-			osnoise_hist_usage(NULL);
+			osnoise_hist_usage();
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -619,18 +613,18 @@ static struct common_params
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
-				osnoise_hist_usage("Period longer than 10 s\n");
+				fatal("Period longer than 10 s\n");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				osnoise_hist_usage("Invalid -P priority");
+				fatal("Invalid -P priority\n");
 			params->common.set_sched = 1;
 			break;
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_hist_usage("Runtime shorter than 100 us\n");
+				fatal("Runtime shorter than 100 us\n");
 			break;
 		case 's':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -670,7 +664,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s\n", optarg);
 			} else {
-				osnoise_hist_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e\n");
 			}
 			break;
 		case '5': /* filter */
@@ -679,7 +673,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s\n", optarg);
 			} else {
-				osnoise_hist_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e\n");
 			}
 			break;
 		case '6':
@@ -701,7 +695,7 @@ static struct common_params
 				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
-			osnoise_hist_usage("Invalid option");
+			fatal("Invalid option\n");
 		}
 	}
 
@@ -712,7 +706,7 @@ static struct common_params
 		fatal("rtla needs root permission\n");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
-		osnoise_hist_usage("no-index set and with-zeros not set - it does not make sense");
+		fatal("no-index set and with-zeros not set - it does not make sense\n");
 
 	return &params->common;
 }
-- 
2.51.0


