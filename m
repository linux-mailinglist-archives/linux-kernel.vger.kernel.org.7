Return-Path: <linux-kernel+bounces-783332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23431B32BC0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 21:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C417F5A53F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518672E8B6F;
	Sat, 23 Aug 2025 19:56:49 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C521E9B22;
	Sat, 23 Aug 2025 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979008; cv=none; b=uzn0vsbjsDZAS8mLuK+y9IiPZzEutJman6ml36oNASIAFIaWRWe0IcKQeJiLoLfqz8BJ9vdnEdzmVsjQPeakqcprUSMdTi6d2pekxlDQM6NG4j2xsjPwVNzt9KKlMBCNgBd1Jc79CqKg3dhHgUAbS5DcLpVSQEW1EzrMrswjUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979008; c=relaxed/simple;
	bh=8nE1fSE+yjsaVQO0ShGspJax1NWVIQi5j4mdBr71EBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjOJKff4VF3SI0phphJzrUX0Da2lCKcE4C4cnzdAvIqePuCm9LdiqHCDXwvV6273ON9ZTAiqk8cjerRpBUQcdyPrH1zG5JmLstTJ20Uc5TBSuXC1uMgO7/vVV0w26WGkI9pvvwCzh4bLmfrprIBTqVjS6I+EB+GK4RYiinl5Hgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ead79b5so101187b3a.3;
        Sat, 23 Aug 2025 12:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755979006; x=1756583806;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq9N4gEoMvcqsSh3vt5cmw1/vSU+BcdEVrt4CK+dOs0=;
        b=WCpYmzJ78l759LJc66epnOntLLwk9fZkCeQ+UmxIOdaSB2j6474ypINcr1ygc3a1zx
         YUXgVFU2zB0SBjWTchqY9184SZZXx476oGtzL/sG9/uXWUtOEIlcVZqe2Cw0SbCxsoOj
         09WlhWJN5uiEu/GiyUV7Fwv3P8VdQvgyClEaxNGrsXCQS11KnkGnRQFy4HFBO/aYsmsn
         t/ihw07K47W9dFs1492rAQUhAy/Q1GKYihLNfsmdCViebhgVv9lfJ8m7b3jeI/Vp8frC
         cW3+Wmgm7rvC2je1L0+BYTqueZf5URucyEJC68E/3cZOeZXpbKdI01UqMoiOiIza0kt2
         gRGg==
X-Forwarded-Encrypted: i=1; AJvYcCX0u2Kl13FI5QMXx7d307V8ykN+afJ1Ec0IRtJq3hXiJxfhtEC/B2RWcIQPvXddf5HrK/CPhcwCX9k=@vger.kernel.org, AJvYcCX6FH1vJiwx7qvIELiyF+gyBN9/fYonqPxPLxjdq/lVotvHnNeT9QsqOtP4DKBs6bGY7oe9Y+Z90t2+nfAf@vger.kernel.org
X-Gm-Message-State: AOJu0YwTaSgXz8Rhm48F14B9UOA+ZJbCzUnXMGXQBffLPSykQ8l4Tw8H
	FRZo7Ts47JKaFTrGpApMQCD4WjP04f2CAdueaL0IuBGPs1EukL0NJuH/
X-Gm-Gg: ASbGnct6QmXFdJPZfxYgwZ0L3p2KoZnUckQD8y5tpGVjSXKzPnT3Ie5L08liZY9Udl9
	eNr9sILzGEURha5kwXRSsRSzwrIO66TfEb40WQVauF3rj7i1ACWrs8WZq78cwglON+uLzVVpQq7
	WTTMiYMca9MX5vGvXeI0qK0Lb8vNaS0pHIt/q7qWVxERD5MLv0Jfkj3HRcsbDVJDU5sB2BvsZOX
	vChxvvd0DuDpvXMIDBf9OV94+UwAKjrcMlA5AzXeDX7fdvqmNU3wta7G6KYOb52YKz/cKYBZz6Y
	burJbafXtu89E7qcjGqE3suLHz5ytcfPiZ1ChSKLcs/75TXzUzwYvTvVtFP9IzdThKtPSJeYkNb
	mNSsTHwwW73+rNemv47JdRR3a3Ev1ieU1RxQBj8/JgBLnrNy7heia+E09S2NsgKQG61kCTxT3px
	nLFHlVNxYTht9CdIqARA==
X-Google-Smtp-Source: AGHT+IEN+R/6AWMq+g3dKvCOBFyGeGUj+hgzeaE5Wsf0RbUoeat7Pes4KWCLRbHq5SrPpR/vGQUcpA==
X-Received: by 2002:a05:6a00:391f:b0:730:87b2:e848 with SMTP id d2e1a72fcca58-7702fb0043emr4360584b3a.5.1755979005818;
        Sat, 23 Aug 2025 12:56:45 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040214decsm3098954b3a.97.2025.08.23.12.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 12:56:45 -0700 (PDT)
Message-ID: <a7c3403b-9f92-40ad-a745-7b610373b736@kzalloc.com>
Date: Sun, 24 Aug 2025 04:56:37 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] Documentation: cve Korean translation
To: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Hyunchul Lee <cheol.lee@lge.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Minwoo Im <minwoo.im@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Chanho Min <chanho.min@lge.com>, Taehee Yoo <ap420073@gmail.com>,
 Harry Yoo <harry.yoo@oracle.com>, gwan-gyeong.mun@intel.com,
 yeoreum.yun@arm.com, Mingi Cho <mgcho.minic@gmail.com>,
 Hyunwoo Kim <imv4bel@gmail.com>, austindh.kim@gmail.com, pmnxis@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250823193516.19485-2-ysk@kzalloc.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250823193516.19485-2-ysk@kzalloc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thank you, Seongjae, for your review.

I've checked the parts you commented on so that you can review it quickly.

>> It woudl be nice to add changes you made on top of previous versions and links
>> to those versions.  That can help reviewers.

I missed including the link earlier. Here it is:

 v6: https://lore.kernel.org/lkml/20250822131829.50331-2-ysk@kzalloc.com/
 v5: https://lore.kernel.org/lkml/20240605010811.19445-1-yskelg@gmail.com/
 v4: https://lore.kernel.org/lkml/20240603161530.80789-1-yskelg@gmail.com/
 v3: https://lore.kernel.org/lkml/20240527103003.29318-1-yskelg@gmail.com/
 v2: https://lore.kernel.org/lkml/20240527102313.27966-1-yskelg@gmail.com/
 v1: https://lore.kernel.org/lkml/20240511195942.30857-1-yskelg@gmail.com/

On 8/24/25 4:35 AM, Yunseong Kim wrote:
> Understanding the Linux kernel's CVE handling process is becoming
> increasingly critical. This is especially important for Korean companies
> exporting products to regions like Europe, as they must comply with
> regulations such as the Cyber Resilience Act (CRA).
> 
> This translation aims to raise awareness among Korean kernel developers and
> companies, helping them better understand and adhere to the kernel
> community's security practices.
> 
> The translation is based on the contributor's direct experience with the
> Linux kernel security bug process and obtaining CVEs. Furthermore,
> completion of the security training program provided by the Linux
> Foundation ensures the necessary accuracy for this documentation.
> 
> I have refined the context that was present in v6. The review comments from
> Seongjae have been incorporated.
> 
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/translations/ko_KR/index.rst    |   1 +
>  .../translations/ko_KR/process/cve.rst        | 125 ++++++++++++++++++
>  2 files changed, 126 insertions(+)
>  create mode 100644 Documentation/translations/ko_KR/process/cve.rst
> 
> diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/translations/ko_KR/index.rst
> index a20772f9d61c..0bf8f775a215 100644
> --- a/Documentation/translations/ko_KR/index.rst
> +++ b/Documentation/translations/ko_KR/index.rst
> @@ -12,6 +12,7 @@
>     :maxdepth: 1
>  
>     process/howto
> +   process/cve
>     core-api/wrappers/memory-barriers.rst
>  
>  .. raw:: latex
> diff --git a/Documentation/translations/ko_KR/process/cve.rst b/Documentation/translations/ko_KR/process/cve.rst
> new file mode 100644
> index 000000000000..d8d011547877
> --- /dev/null
> +++ b/Documentation/translations/ko_KR/process/cve.rst
> @@ -0,0 +1,125 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +NOTE:
> +This is a version of Documentation/process/cve.rst translated into Korean.
> +This document is maintained by Yunseong Kim <ysk@kzalloc.com>.
> +If you find any difference between this document and the original file or
> +a problem with the translation, please contact the maintainer of this file.
> +
> +Please also note that the purpose of this file is to be easier to
> +read for non English (read: Korean) speakers and is not intended as
> +a fork.  So if you have any comments or updates for this file please
> +update the original English file first.  The English version is
> +definitive, and readers should look there if they have any doubt.
> +
> +================================================================
> +이 문서는
> +Documentation/process/cve.rst
> +의 한글 번역입니다.
> +
> +:역자: 김윤성 <ysk@kzalloc.com>
> +:감수: 박진우 <pmnxis@gmail.com>, 김동현 <austindh.kim@gmail.com>

>> Please take my Reviewed-by tag, only after you remove my name from "감수"
>> section. Again, please don't add my Reviewed-by tag without removing my
>> name from the above part.

Alright, I applied it. :)

> +================================================================
> +
> +=================
> +CVE 항목들 (CVEs)
> +=================
> +
> +공통 취약점 및 노출(Common Vulnerabilities and Exposure, CVE®) 번호는 공개적으로
> +알려진 보안 취약점을 식별, 정의하고 목록화하기 위한 명확한 방법으로
> +개발되었습니다. 하지만 시간이 지나면서 커널 프로젝트에서는 그 유용성이
> +감소했으며, CVE 번호가 부적절한 방식과 이유로 할당되는 경우가 매우 많았습니다.
> +이 때문에 커널 개발 커뮤니티는 CVE 사용을 꺼리는 경향이 있었습니다. 그러나
> +CVE 및 기타 보안 식별자 할당에 대한 지속적인 압력과, 커널 커뮤니티 외부의
> +개인 및 회사들의 지속적인 남용이 결합되면서, 커널 커뮤니티가 이러한 할당에
> +대한 통제권을 가져야 한다는 점이 명확해졌습니다.
> +
> +리눅스 커널 개발팀은 잠재적인 리눅스 커널 보안 이슈에 대해 CVE를 할당할 수
> +있습니다. 이 할당은 :doc:`일반적인 리눅스 커널 보안 버그 보고
> +절차<Documentation/process/security-bugs>`와는 독립적으로 이루어집니다.
> +
> +리눅스 커널에 할당된 모든 CVE 목록은 linux-cve 메일링 리스트 아카이브
> +(https://lore.kernel.org/linux-cve-announce/)에서 확인할 수 있습니다.
> +할당된 CVE에 대한 알림을 받으려면 해당 메일링 리스트를
> +`구독<https://subspace.kernel.org/subscribing.html>`_ 하시기 바랍니다.
> +
> +할당 절차 (Process)
> +===================

>> I think most Korean readers would understand above, but to be more
>> Korean-friendly, what about using more Korean-translated term, e.g., "할당
>> 절차"?

I chose your suggestion, more smooth to read!

> +일반적인 안정(stable) 릴리스 프로세스의 일부로, 잠재적으로 보안 이슈가 될 수
> +있는 커널 변경 사항은 CVE 번호 할당 담당 개발자가 식별하여 자동으로 CVE 번호가
> +할당됩니다. 이러한 할당 내역은 linux-cve-announce 메일링 리스트에 공지사항으로
> +빈번하게 게시됩니다.
> +
> +참고로, 리눅스 커널이 시스템에서 차지하는 계층의 특성상 거의 모든 버그가 커널
> +보안을 침해하는 데 악용될 수 있지만, 버그가 수정될 당시에는 악용 가능성이
> +명확하지 않은 경우가 많습니다. 이 때문에 CVE 할당 팀은 매우 신중하게
> +접근하며(overly cautious), 식별한 모든 버그 수정(bugfix)에 CVE 번호를
> +할당합니다. 이는 리눅스 커널 팀이 발행하는 CVE의 수가 겉보기에 많아 보이는
> +이유를 설명합니다.
> +
> +만약 CVE 할당 팀이 놓친 특정 수정 사항에 대해 CVE가 할당되어야 한다고 생각되면,
> +<cve@kernel.org>로 이메일을 보내주십시오. 담당 팀이 협력할 것입니다.
> +이 이메일 주소는 이미 릴리스된 커널 트리에 포함된 수정 사항에 대한 CVE 할당
> +전용이며, 잠재적인 보안 이슈를 보내서는 안 된다는 점에 유의하십시오.
> +아직 수정되지 않은 보안 이슈를 발견했다고 생각되면 :doc:`일반적인 리눅스
> +커널 보안 버그 보고 절차<Documentation/process/security-bugs>` 를 따르십시오.
> +
> +리눅스 커널의 수정되지 않은 보안 이슈에 대해서는 CVE가 자동으로 할당되지
> +않습니다. 할당은 수정 사항이 제공되고 안정(stable) 커널 트리에 적용된 후에만
> +자동으로 이루어지며, 원본 수정 사항의 git 커밋 ID로 추적됩니다. 커밋으로
> +이슈가 해결되기 전에 CVE를 할당받고자 하는 경우, 커널 CVE 할당
> +팀(<cve@kernel.org>)에 연락하여 예약된 식별자 목록에서 할당받을 수 있습니다.
> +
> +현재 안정/장기 지원 버전(Stable/LTS) 담당 커널 팀이 적극적으로 지원하지 않는
> +커널 버전에서 발견된 이슈에 대해서는 CVE가 할당되지 않습니다. 현재 지원되는
> +커널 브랜치 목록은 https://kernel.org/releases.html 에서 확인할 수 있습니다.
> +
> +할당된 CVE에 대한 이의 제기 (Disputes)
> +======================================
> +
> +특정 커널 변경 사항에 할당된 CVE에 대해 이의를 제기하거나 수정할 권한은 오직
> +영향을 받는 관련 서브시스템의 메인테이너에게만 있습니다. 이 원칙은 취약점
> +보고의 높은 정확성과 책임성을 보장합니다. 서브시스템에 대한 깊은 전문 지식과
> +긴밀한 이해(intimate knowledge)를 가진 개인만이 보고된 취약점의 유효성과
> +범위를 효과적으로 평가하고 적절한 CVE 지정을 결정할 수 있습니다. 이 지정된
> +권한 밖에서 CVE를 수정하거나 이의를 제기하려는 시도는 혼란, 부정확한 보고,
> +그리고 궁극적으로 시스템 침해로 이어질 수 있습니다.
> +
> +무효한 CVE (Invalid CVEs)
> +=========================

>> What about making it shorter and simlper, e.g., s/유효하지 않은/ 무효한/ ?
>>
>> No strong opinion.  The current one is also good for me.

Great, make this simple. :)

> +리눅스 배포판이 자체적으로 적용한 변경 사항 때문에 해당 배포판에서만 지원되는
> +리눅스 커널에서 보안 이슈가 발견된 경우, 또는 배포판이 더 이상 kernel.org에서
> +지원하는 않는 커널 버전을 사용하여 보안 이슈가 발견된 경우, 리눅스 커널 CVE
> +팀은 CVE를 할당할 수 없으며 해당 리눅스 배포판에 직접 요청해야 합니다.
>> Maybe above can be shorter and easier to read, e.g.,
>> s/지원하는 릴리스가 아닌/지원하지 않는 이유/ ?
>>
>> Again, no strong opinion.  The current one also look good to me.

I think "지원하는 않는" better to understand than "지원하는 릴리스 아닌",
Thank you for the catching it!

> +현재 공식 지원 중인 커널 버전에 대해, 커널 CVE 할당 팀 외 다른 그룹이 지정한

>>  I personally feel "적극적으로" is not a good translation of "actively" here,
>> but I also have no good better idea.  I think this is also good enough.

I think it’s better to use a more context-appropriate word rather than the
literal translation "Actively" Thank you for your thorough review.

> +CVE는 유효한 CVE로 인정되어선 안 됩니다. 커널 CVE 할당 팀(<cve@kernel.org>)에
> +알려주시면 CNA(CVE Numbering Authority) 시정(remediation) 절차를 통해 해당
> +항목을 무효화 조치할 것입니다.
> +
> +특정 CVE의 적용 가능성 (Applicability)
> +======================================
> +
> +리눅스 커널은 다양한 방식으로 사용될 수 있으며, 외부 사용자가 접근하는 방식도
> +다양하거나 아예 접근이 없을 수도 있습니다. 따라서 특정 CVE의 적용 가능성(해당
> +여부)은 CVE 할당 팀이 아닌 리눅스 사용자가 결정해야 합니다. 특정 CVE의 적용
> +가능성을 판단하기 위해 저희에게 연락하지 마십시오.
> +
> +또한, 소스 트리는 매우 방대하고 개별 시스템은 소스 트리의 작은 부분 집합만을
> +사용하므로, 리눅스 사용자는 할당된 수많은 CVE가 자신의 시스템과 관련이 없다는
> +점을 인지해야 합니다.
> +
> +요컨대, 저희는 귀하의 사용 사례(use case)를 알지 못하며 귀하가 커널의 어느
> +부분을 사용하는지 알지 못하므로, 특정 CVE가 귀하의 시스템과 관련이 있는지
> +판단할 방법이 없습니다.
> +
> +언제나 그렇듯이, 개별적으로 선별된 변경 사항이 아니라, 많은 커뮤니티 구성원들에

>> I think this translation is good enough to just remove "(체리픽된)".  I'm
>> rather feel like "체리픽된" _might_ confuse some Korean readers.  Again, no
>> strong opinion but a personal and uncautiosly biased feeling.

I think if we change this part to '(체리픽된)' it would mean converting
everything into Korean transliterations of English words, which doesn’t
seem ideal.

> +의해 통합된 전체로서 함께 테스트된 모든 릴리스된 커널 변경 사항을 적용하는 것이
> +가장 좋습니다. 또한 많은 버그의 경우, 전체 문제에 대한 해결책은 단일 변경 사항이
> +아니라 서로 중첩된 많은 수정 사항의 합으로 발견된다는 점에 유의하십시오.
> +이상적으로는 모든 이슈에 대한 모든 수정 사항에 CVE가 할당되지만, 때때로 저희가
> +수정 사항을 인지하지 못할 수 있습니다. 따라서 CVE가 할당되지 않은 일부 변경
> +사항도 적용하는 것이 관련 있을 수 있다고 가정하십시오.

>> Why don't you add a new line at the end of the file? 🙂

I added it.

Again, Thank you Seongjae for the thorough review.

Best regards,
Yunseong


