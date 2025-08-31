Return-Path: <linux-kernel+bounces-793495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6DB3D451
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4B63BA5F9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3E1A76BB;
	Sun, 31 Aug 2025 16:18:26 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA82581;
	Sun, 31 Aug 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756657105; cv=none; b=Pt1olS9fOXfCxm189ffqpBkRfwLwseheODjBmEu6Er5AHWo6mTtMc3NzIBFX1k7mtbKAehXYqsm/RG0m7uY53qMJ2htX24dVm2Heh7ptJgc7tEPx04K3y67QZsBkUET3bIUBSBTOkUeeUrGculP5WWUamsHYB41BnFUCwQOHaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756657105; c=relaxed/simple;
	bh=AlZqi77j4tZq9+hCm6jqUyK1j7aIr9HWaAQF/Iat0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ItqU/nDRN6tWt8ouST32ItQBKtdCIgx1Ba+4YlKn/8hyygu+pZSk09ttIUb7vz2B3j+OtkMoeRsPeSZrc/TZqdYHF7vppJctZqg0OntC5YTv0ne+bTWhpLIqRlkiB+Vpm6ep2KuVHUWQ6vnRy5/MiEPIWkEFJzxQKeyKf1dFZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2489b7f3d5fso7754535ad.0;
        Sun, 31 Aug 2025 09:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756657103; x=1757261903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPgL1f0se+xmCF5cJxlkGRoiKTVxgJno4fZZaW2VANc=;
        b=Kb1tfYd3LF+KKWFoQn0FQv9ra4PThErJzbkdFfBvQ/wYaI8dJlgOduDbnz1W4qJD9m
         KwKwxKk5fkhcm6sBX/QsNQYxU6I1hHBhw9JaZT1d54FrSRTOLi2MIFncSUGVI9HeTcaD
         IchYTy1QkSxDSesCTJDzVwxpP21vn1SGRegb4xMH+CgIsR4Hk1BKmuUGTm9zGVJAqefM
         mALAr5RFvuPT71qtEkSxxdiNGyyR58xJyl3W4/WijzpQJwcd4jbk99k/IRFLljm+TDEn
         39kowGSpvAHWOrQnM0MeSlfib5o3juphg3g0OUQTel2Xw2c6zNMO9qVIfr5Wj30Oso75
         WE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW358D4vdpwuIvHQKUQYPoIgux2kPJF4vJCdk5wqxr8bxJbT0NTuuaTea/Kwpy26ap0+OPlx+Q5j77UWDY5@vger.kernel.org, AJvYcCWR7fJPtT9Kl4HhlVPQEZgQDufcg0+cd+TEiT+S4GB6gWEuPg5Af7wUuJllryxSHkLpPmSaPO6U05o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbg6YRK5vb4RMkaZVocuwGQDJib3nHhjJ84KIoFR3oqCJ0gLjU
	FryI+wIYxnYUMzotMEgHxJPRtcYGMxIkWuq3RNewmvMLu7rxpPHGYB+H
X-Gm-Gg: ASbGncuG2vtkAGiuZgtuww7d75aB/OW7yo/6n1BgbEaSat1Ag2NPykpIfu1FxN7+DJN
	z7eg9ESNPKZmLth3sBeNDyDYiBtZmaEis9JOoJBtJ9lHzRXbWoj7FVrPg6mAKaq82BEFbSE/auP
	kqbwQtklQzcGSj6l+I3MmVZy7Htp6Hhwm8YtId9KwCzsIwquMIWaNIIco4ITplFlJO+WpBmO0lC
	PcQy96qm0yqIP+ZqbtKo+UDrOA/LW1BZRHNWmbvwfmJMSrHhMRKUlTBOLzCO893RjBApXUEOlgi
	enmjaaJv6/R7sG17lx9wWHmUIewq99/4fnwde3mTW+8ElofU2CIedtrDFcAypwzw4p3mTUupg3M
	eMhBeU6ENdXKyEFhD0JcGX/RwTO/rYumXAGleticvA6lkoVwGB7IaUvSL/jfNFingwqAxdh92Nt
	XK5r1bjQ96Kw==
X-Google-Smtp-Source: AGHT+IFTUEpW76fHmr9GSqQUg6NUG8aP3mwlJdthzy9852Xyp6ayZ6AFEOq4NC3awYEjc/vUh9dAvg==
X-Received: by 2002:a17:902:f790:b0:24a:af25:34dd with SMTP id d9443c01a7336-24aaf2537acmr14382175ad.10.1756657102779;
        Sun, 31 Aug 2025 09:18:22 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77244d42b0esm3798774b3a.80.2025.08.31.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 09:18:22 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Tejun Heo <tj@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyunchul Lee <cheol.lee@lge.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Minwoo Im <minwoo.im@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kukjin Kim <kgene@kernel.org>,
	Chanho Min <chanho.min@lge.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	gwan-gyeong.mun@intel.com,
	yeoreum.yun@arm.com,
	Mingi Cho <mgcho.minic@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	austindh.kim@gmail.com,
	pmnxis@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH v8] Documentation: cve Korean translation
Date: Sun, 31 Aug 2025 16:16:57 +0000
Message-ID: <20250831161657.1414453-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Understanding the Linux kernel's CVE handling process is becoming
increasingly critical. This is especially important for Korean companies
exporting products to regions like Europe, as they must comply with
regulations such as the Cyber Resilience Act (CRA).

This translation aims to raise awareness among Korean kernel developers and
companies, helping them better understand and adhere to the kernel
community's security practices.

The translation is based on the contributor's direct experience with the
Linux kernel security bug process and obtaining CVEs. Furthermore,
completion of the security training program provided by the Linux
Foundation ensures the necessary accuracy for this documentation.

After the v7 patch, Austin Kim requested to be removed from the
Translation Review list, so I deleted his name and fixed the parts that
were causing the document build to fail.

Below is a link where the changes to the translation so far can be
tracked version:

[1] https://lore.kernel.org/lkml/20240511195942.30857-1-yskelg@gmail.com/
[2] https://lore.kernel.org/lkml/20240527102313.27966-1-yskelg@gmail.com/
[3] https://lore.kernel.org/lkml/20240527103003.29318-1-yskelg@gmail.com/
[4] https://lore.kernel.org/lkml/20240603161530.80789-1-yskelg@gmail.com/
[5] https://lore.kernel.org/lkml/20240605010811.19445-1-yskelg@gmail.com/
[6] https://lore.kernel.org/lkml/20250822131829.50331-2-ysk@kzalloc.com/
[7] https://lore.kernel.org/lkml/20250823193516.19485-2-ysk@kzalloc.com/

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 Documentation/translations/ko_KR/index.rst    |   1 +
 .../translations/ko_KR/process/cve.rst        | 137 ++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/translations/ko_KR/process/cve.rst

diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/translations/ko_KR/index.rst
index a20772f9d61c..0bf8f775a215 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -12,6 +12,7 @@
    :maxdepth: 1
 
    process/howto
+   process/cve
    core-api/wrappers/memory-barriers.rst
 
 .. raw:: latex
diff --git a/Documentation/translations/ko_KR/process/cve.rst b/Documentation/translations/ko_KR/process/cve.rst
new file mode 100644
index 000000000000..8619cb23a739
--- /dev/null
+++ b/Documentation/translations/ko_KR/process/cve.rst
@@ -0,0 +1,137 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. raw:: latex
+
+	\kerneldocCJKoff
+
+NOTE:
+This is a version of Documentation/process/cve.rst translated into Korean.
+This document is maintained by Yunseong Kim <ysk@kzalloc.com>.
+If you find any difference between this document and the original file or
+a problem with the translation, please contact the maintainer of this file.
+
+Please also note that the purpose of this file is to be easier to
+read for non English (read: Korean) speakers and is not intended as
+a fork.  So if you have any comments or updates for this file please
+update the original English file first.  The English version is
+definitive, and readers should look there if they have any doubt.
+
+----------------------------------
+
+.. raw:: latex
+
+	\kerneldocCJKon
+
+이 문서는
+Documentation/process/cve.rst
+의 한글 번역입니다.
+
+:역자: 김윤성 <ysk@kzalloc.com>
+:감수: 박진우 <pmnxis@gmail.com>
+
+----------------------------------
+
+=================
+CVE 항목들 (CVEs)
+=================
+
+공통 취약점 및 노출(Common Vulnerabilities and Exposure, CVE®) 번호는 공개적으로
+알려진 보안 취약점을 식별, 정의하고 목록화하기 위한 명확한 방법으로
+개발되었습니다. 하지만 시간이 지나면서 커널 프로젝트에서는 그 유용성이
+감소했으며, CVE 번호가 부적절한 방식과 이유로 할당되는 경우가 매우 많았습니다.
+이 때문에 커널 개발 커뮤니티는 CVE 사용을 꺼리는 경향이 있었습니다. 그러나
+CVE 및 기타 보안 식별자 할당에 대한 지속적인 압력과, 커널 커뮤니티 외부의
+개인 및 회사들의 지속적인 남용이 결합되면서, 커널 커뮤니티가 이러한 할당에
+대한 통제권을 가져야 한다는 점이 명확해졌습니다.
+
+리눅스 커널 개발팀은 잠재적인 리눅스 커널 보안 이슈에 대해 CVE를 할당할 수
+있습니다. 이 할당은
+:doc:`일반적인 리눅스 커널 보안 버그 보고 절차</process/security-bugs>`
+와는 독립적으로 이루어집니다.
+
+리눅스 커널에 할당된 모든 CVE 목록은 linux-cve 메일링 리스트 아카이브
+https://lore.kernel.org/linux-cve-announce/ 에서 확인할 수 있습니다.
+할당된 CVE에 대한 알림을 받으려면 해당 메일링 리스트를
+`구독<https://subspace.kernel.org/subscribing.html>`_ 하시기 바랍니다.
+
+할당 절차 (Process)
+===================
+
+일반적인 안정(stable) 릴리스 프로세스의 일부로, 잠재적으로 보안 이슈가 될 수
+있는 커널 변경 사항은 CVE 번호 할당 담당 개발자가 식별하여 자동으로 CVE 번호가
+할당됩니다. 이러한 할당 내역은 linux-cve-announce 메일링 리스트에 공지사항으로
+빈번하게 게시됩니다.
+
+참고로, 리눅스 커널이 시스템에서 차지하는 계층의 특성상 거의 모든 버그가 커널
+보안을 침해하는 데 악용될 수 있지만, 버그가 수정될 당시에는 악용 가능성이
+명확하지 않은 경우가 많습니다. 이 때문에 CVE 할당 팀은 매우 신중하게
+접근하며(overly cautious), 식별한 모든 버그 수정(bugfix)에 CVE 번호를
+할당합니다. 이는 리눅스 커널 팀이 발행하는 CVE의 수가 겉보기에 많아 보이는
+이유를 설명합니다.
+
+만약 CVE 할당 팀이 놓친 특정 수정 사항에 대해 CVE가 할당되어야 한다고 생각되면,
+<cve@kernel.org>로 이메일을 보내주십시오. 담당 팀이 협력할 것입니다.
+이 이메일 주소는 이미 릴리스된 커널 트리에 포함된 수정 사항에 대한 CVE 할당
+전용이며, 잠재적인 보안 이슈를 보내서는 안 된다는 점에 유의하십시오.
+아직 수정되지 않은 보안 이슈를 발견했다고 생각되면
+:doc:`일반적인 리눅스 커널 보안 버그 보고 절차</process/security-bugs>`
+를 따르십시오.
+
+리눅스 커널의 수정되지 않은 보안 이슈에 대해서는 CVE가 자동으로 할당되지
+않습니다. 할당은 수정 사항이 제공되고 안정(stable) 커널 트리에 적용된 후에만
+자동으로 이루어지며, 원본 수정 사항의 git 커밋 ID로 추적됩니다. 커밋으로
+이슈가 해결되기 전에 CVE를 할당받고자 하는 경우, 커널 CVE 할당
+팀<cve@kernel.org>에 연락하여 예약된 식별자 목록에서 할당받을 수 있습니다.
+
+현재 안정/장기 지원 버전(Stable/LTS) 담당 커널 팀이 적극적으로 지원하지 않는
+커널 버전에서 발견된 이슈에 대해서는 CVE가 할당되지 않습니다. 현재 지원되는
+커널 브랜치 목록은 https://kernel.org/releases.html 에서 확인할 수 있습니다.
+
+할당된 CVE에 대한 이의 제기 (Disputes)
+======================================
+
+특정 커널 변경 사항에 할당된 CVE에 대해 이의를 제기하거나 수정할 권한은 오직
+영향을 받는 관련 서브시스템의 메인테이너에게만 있습니다. 이 원칙은 취약점
+보고의 높은 정확성과 책임성을 보장합니다. 서브시스템에 대한 깊은 전문 지식과
+긴밀한 이해(intimate knowledge)를 가진 개인만이 보고된 취약점의 유효성과
+범위를 효과적으로 평가하고 적절한 CVE 지정을 결정할 수 있습니다. 이 지정된
+권한 밖에서 CVE를 수정하거나 이의를 제기하려는 시도는 혼란, 부정확한 보고,
+그리고 궁극적으로 시스템 침해로 이어질 수 있습니다.
+
+무효한 CVE (Invalid CVEs)
+=========================
+
+리눅스 배포판이 자체적으로 적용한 변경 사항 때문에 해당 배포판에서만 지원되는
+리눅스 커널에서 보안 이슈가 발견된 경우, 또는 배포판이 더 이상 kernel.org에서
+지원하는 않는 커널 버전을 사용하여 보안 이슈가 발견된 경우, 리눅스 커널 CVE
+팀은 CVE를 할당할 수 없으며 해당 리눅스 배포판에 직접 요청해야 합니다.
+
+현재 공식 지원 중인 커널 버전에 대해, 커널 CVE 할당 팀 외 다른 그룹이 지정한
+CVE는 유효한 CVE로 인정되어선 안 됩니다. 커널 CVE 할당 팀<cve@kernel.org>에
+알려주시면 CNA(CVE Numbering Authority) 시정(remediation) 절차를 통해 해당
+항목을 무효화 조치할 것입니다.
+
+특정 CVE의 적용 가능성 (Applicability)
+======================================
+
+리눅스 커널은 다양한 방식으로 사용될 수 있으며, 외부 사용자가 접근하는 방식도
+다양하거나 아예 접근이 없을 수도 있습니다. 따라서 특정 CVE의 적용 가능성(해당
+여부)은 CVE 할당 팀이 아닌 리눅스 사용자가 결정해야 합니다. 특정 CVE의 적용
+가능성을 판단하기 위해 저희에게 연락하지 마십시오.
+
+또한, 소스 트리는 매우 방대하고 개별 시스템은 소스 트리의 작은 부분 집합만을
+사용하므로, 리눅스 사용자는 할당된 수많은 CVE가 자신의 시스템과 관련이 없다는
+점을 인지해야 합니다.
+
+요컨대, 저희는 귀하의 사용 사례(use case)를 알지 못하며 귀하가 커널의 어느
+부분을 사용하는지 알지 못하므로, 특정 CVE가 귀하의 시스템과 관련이 있는지
+판단할 방법이 없습니다.
+
+언제나 그렇듯이, 개별적으로 선별된 변경 사항이 아니라, 많은 커뮤니티 구성원들에
+의해 통합된 전체로서 함께 테스트된 모든 릴리스된 커널 변경 사항을 적용하는 것이
+가장 좋습니다. 또한 많은 버그의 경우, 전체 문제에 대한 해결책은 단일 변경 사항이
+아니라 서로 중첩된 많은 수정 사항의 합으로 발견된다는 점에 유의하십시오.
+이상적으로는 모든 이슈에 대한 모든 수정 사항에 CVE가 할당되지만, 때때로 저희가
+수정 사항을 인지하지 못할 수 있습니다. 따라서 CVE가 할당되지 않은 일부 변경
+사항도 적용하는 것이 관련 있을 수 있다고 가정하십시오.
+
-- 
2.50.0


