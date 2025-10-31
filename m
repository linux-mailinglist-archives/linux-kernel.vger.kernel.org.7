Return-Path: <linux-kernel+bounces-879879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76A1C244FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948DB1885459
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B6333752;
	Fri, 31 Oct 2025 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lbiny0kJ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A7329E61
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904615; cv=none; b=IDZCqmDnsUGg58dTgeToSI5MczsZATm3FCmo1PGSklUdWU9TtW02APdh9obeuvc6NlGGU3iKu+f6enmWmqPbW63l5CisKi0AYou49rmuNrr5BKhsb3LHlvUxEmeyLbzHzWGzyDkGZMvwx7arkZl2NR8LuYlgWsZaaYFxy5kYIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904615; c=relaxed/simple;
	bh=BYypTgcDigkcBmFHA4laiIndTxEdaEOD4+KOdapMVfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Puvz0zeJ4UNwclvSv1huAvMfGk+i/L57BcU3S0uT6e+jHt2q+eQAliWs2eVNOecRi0G3bi8Wq+tvYKiM5wIvOfCIalWh36n6ed0ESM1Xd624tL1eA+OMMUjgRdFhlJ613+SSdEC6oDaMs/J+whWgoLPZdgnsdP24nCv8/26msqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lbiny0kJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so18269565e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761904611; x=1762509411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGFmEOvar0Fpd4GQVUBKBaZSe79j0hdehGZvY1C+ml0=;
        b=Lbiny0kJCtAKKB6mGh7KJ47hjBn/r9xsX9FAWQ2Aph1Gaw+HouC+ns4SgiCL+Xd89V
         6Od1Jgpewx5w5ZxVXAjOuCJBfxT3huxuJa5LtJensXAdfti4Dxj17eWdbXO2RTWTbXei
         aaqV4EufcoVZVAhnP9jCaTwPTu/rUbNurc7F/MRDAcYLzjIQJqQUGQW3vh+Anm/nrtio
         T4mrQkF0Uly0A9bl4XO40H+fLjWaj220YIG1Uh5409NLrUM5pn3NZSUMgpoQGidYjASY
         bR1wLGEqAFExy2I1M0qmPsn6BTV7SWXQMEO9bo9RA8iv2VJa3Rk88vePDl31CvPIKgP7
         djPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904611; x=1762509411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGFmEOvar0Fpd4GQVUBKBaZSe79j0hdehGZvY1C+ml0=;
        b=Lw82qTNYYs/pVLdUULzNLyirpGrMimaM55z+MbIjK92jNniVZAmET1COKchzcRSQ14
         6w8mYrHJgU8WHq2iBRKUFuKOW8+h21ZvjEBN+7lyTT67TzwLC7C0tXuxDdLYMis8Z629
         UFl6JPSRFhH/ukVAWDtrIVp1+gOYAWA1k6UtbVwzJ5Vy2U1emdDOHPGXQJW3VCJT0PSw
         upNww2eErsoTSRxa+W5HP977pZ6f3jJ3ahtMy0PJJTE3CbAHB3ylQJjiDYm5QXLpGfwu
         fL5LL0uHrcFsqWMG//HQT8qDXWcD+LPi1dWmRjvvfcecSyFA4jYKJtVH+c1R2r2HFgwV
         qKjg==
X-Gm-Message-State: AOJu0YyJG4fsWJ4XPFSuXJn41GHalijWPWgi+STL0Qw6EO4NEqNEaVU+
	PidaozEMW2kqhuR6NRVucwWmRmiqHB1eWbJEiiz/jrVsqfeQhH0ylf08C6SlVyrljsVeRRUH0xy
	stw5s
X-Gm-Gg: ASbGncthnUkHAm5sVKOAauc4T+fknjhKf+WUleT3s1cJ6+V85xMB99ts23kp8uJ+HbR
	WCRfjK1fWkqFPHPQdiqvbfdQ2N01NhXwdeB3CbbvPz8aeB5TCwEbHvFfA1iTQmEsz3Bl1JCvSCv
	s2JXmNL80iDRLMcM3Tf2j5dC3Z5+lC83MKhW/IfvcbwJIMmvsN+jpEHYBFQMic1vbmHsqqBpHOh
	wToxytDvtaYRBAr9sHDhxO2HXOwzEf53qnrqIZXLar5HZdbaOsPi28qLatKzqkL5qaqamCuRzk9
	pz5qkGsOrHhzcTL8/YKbQjGtMJaVz+XIK6WxbYYpXF+jGHwx5OZRojYLELdUvqCxRBykjK7Px8y
	m5GNnKkV0+HbBAiWjnXuxbY9kcihJgSiocHx1SHxixjOReZyBL+wTWuDSg8W9MRDuqNZ3G2BiJM
	toodOXbVUuhfxAJz5+vw1eN7a35k60x+j0RD8=
X-Google-Smtp-Source: AGHT+IHqKtezdLexxMm+hURfDGbndrtBF0wPbPWMF+obXaFM6s3C8AmKAzgO4FIJwhNbgdUfeNWtqQ==
X-Received: by 2002:a05:600c:358f:b0:477:25c0:798c with SMTP id 5b1f17b1804b1-47730175fcfmr31042115e9.20.1761904611156;
        Fri, 31 Oct 2025 02:56:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdfbsm81572335e9.4.2025.10.31.02.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:56:50 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 1/4] scsi: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 31 Oct 2025 10:56:40 +0100
Message-ID: <20251031095643.74246-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031095643.74246-1-marco.crivellari@suse.com>
References: <20251031095643.74246-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/scsi/qla2xxx/qla_os.c       | 2 +-
 drivers/scsi/scsi_transport_iscsi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 5ffd94586652..d48d8671c18a 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5280,7 +5280,7 @@ void qla24xx_sched_upd_fcport(fc_port_t *fcport)
 	qla2x00_set_fcport_disc_state(fcport, DSC_UPD_FCPORT);
 	spin_unlock_irqrestore(&fcport->vha->work_lock, flags);
 
-	queue_work(system_unbound_wq, &fcport->reg_work);
+	queue_work(system_dfl_wq, &fcport->reg_work);
 }
 
 static
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 743b4c792ceb..ed21c032bbc4 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3961,7 +3961,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 			list_del_init(&session->sess_list);
 			spin_unlock_irqrestore(&sesslock, flags);
 
-			queue_work(system_unbound_wq, &session->destroy_work);
+			queue_work(system_dfl_wq, &session->destroy_work);
 		}
 		break;
 	case ISCSI_UEVENT_UNBIND_SESSION:
-- 
2.51.0


