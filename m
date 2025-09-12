Return-Path: <linux-kernel+bounces-814707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7534B5578D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653CA5A712B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA162D0278;
	Fri, 12 Sep 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dpFzoYMZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953982BF016
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708468; cv=none; b=VboLUQVlG+nPXRQlcf+WLTenYMrctGz/sy5MFh11sgZUKS2w62hVGLWcynLc+R2oLzu0EO/1wZFXPwxZDo+AlCRLSDn6AY4xmyTin52iHXt5jG9zyhX0c6sE1b8ketM8JB5JizcqBKbex4oc3pzajyZj/rSkRplOvDMcouXgaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708468; c=relaxed/simple;
	bh=ha5sACqI+T93S9hNt+6tg8vEBhnD3jRHwOofYElvPzs=;
	h=Message-ID:Date:MIME-Version:Subject:From:References:To:Cc:
	 In-Reply-To:Content-Type; b=IhzTpoKL9W+XDqNKvdcNUfHJ5werZE2boim9o1riqj1BKC4nm7Nyu8ZHgaGbTbGfi2wt6RTQ6HeswJG2GhHsjKAizrE0NHY567SykTo7JDtoij2+2u9qD0IZQ6hgUPPvd2SIbvIJv2anJllxb9uRXRMX1piZILiMUYwJOSiy1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dpFzoYMZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CI0uat014022
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uh8HWFGgvQRh4YRN3fk73qzhec8r9FEUaHUe0C5PvU0=; b=dpFzoYMZG1v/fuZZ
	2RiOHciNexepsOY2/E+q6hirgSIhID69Ou8BV9gf506j3uZg5Eyg1aOZTn3HJATt
	izsRV0N8KIa63NihYzi/wdKIsjrvo3Q9Mstv6cveN0mG9y+W5uIkQAuk5nZ7SffF
	SCpZcWhk1ehi5VrtLFFghTgdwVZiKX9kSYL7uICiT22ybmcz6YAkKtxsSRmAe46V
	WsgpfZhH7ssf6RKCR/Cv3ITFT9Djgj10pxJzXJdkSQCZfcpynUiSJu1TjunZY4Tn
	gHQFfBhtAm14Oyd3GlqhuFqV543caaNYYs6ltXn6svrV/nHakTrpOIqeRsCGuK+w
	BSNxYw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphxhg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:21:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7761dd1c845so469095b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757708463; x=1758313263;
        h=content-transfer-encoding:in-reply-to:cc:to:content-language
         :references:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uh8HWFGgvQRh4YRN3fk73qzhec8r9FEUaHUe0C5PvU0=;
        b=kQDIFOqmU75XqELhNfLSi7p2SOSevGg/AMv8p7VhHiEsGnvS24zJd8EuxK+4rzuxjs
         JdFZrmp23Qp1d5DROGYqAf678kBA7ZTgVp6qLmTMQkKZzemZ/qi42nxVkaDI53i3QbyA
         QUFIZ5BnhzbRN/no7WNhGj/SSZZO0ooVW/tzLSiJGZs53xFM0LFiwU9ZtarJHafTKiOD
         U9giFtaPzb37eTN72iTjpFtfaKRaZDW6oZ2YcElMhi+5i3Kfqva/ZAx7tqrOYgLQuF71
         5ZdfwXaQztADAmqUzZRim2T7lZGjUPn73sNppn5P/vRIB6GTLVVmooZQgAXhXERnRK1Q
         URDA==
X-Forwarded-Encrypted: i=1; AJvYcCXBTUKh2kI+KZHVNwvwWI1zcIUavZ2qzcTsGsI5CgHRY4zkAnPcXSwa6Xtvv2a5ZuzrgoxpYFHwcgLcIJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3AseVI5kRYjvmommi9YiDG+AVnfBhXNCFEe1dk5eAUuhjsqj
	y6sCGoA9zrZxlUzEVVyRUgUZ3VaxAiXGdVmf79sXKXh1kh5/7yEYACvnXgVu71teYy7eontC8eZ
	9sqCQf9hZwiMKyCo2tInea9XavDnWcXyrSY0qMXBZeU1tPEqTfBRMS8WxeW7pLUgPXhE=
X-Gm-Gg: ASbGncsbvus7nznwxjse24LmZvYDOBtCGOBhtWRoEILSsXgTCzCnpatd4TIoz9dyY9P
	CfXNH9zDNqjRSPc89tBm7whjBPXWUXIu/B2sSht42ghMI/R8G1SzpY2jZm83DocoFKbg5EVpT3n
	6b3Kou/3cWUpPGh99UCpnPNjkpOlAt36XxUtlIgfXE1ACJYZiQ5pOHgY3GQeh+Oc1ofREDqMMH8
	rJVvA7//gSxX+50S4Ld/xKG6m8n7dHiElnvb1YpgAGeGcZSysXGAOZweH2BJqcBVXu9yXe/78IP
	78IolygOo/7f4+dgMLTGxu6+VFy0+05r6Vs0LbVpSnhil9y4DhSggIoRINnM4kg3vY8Rlo9/yDT
	lrpkpcsl+JJPzl2F1hY1Zbww=
X-Received: by 2002:a05:6a00:181e:b0:772:48c5:c75a with SMTP id d2e1a72fcca58-77612091649mr5033554b3a.13.1757708463017;
        Fri, 12 Sep 2025 13:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy9rA89rMg5iy1ZfZgFDowhXAj7A+YF9TJ6xmj3kp84CbPWPd2rihyHVZcOIc16agMz/VevA==
X-Received: by 2002:a05:6a00:181e:b0:772:48c5:c75a with SMTP id d2e1a72fcca58-77612091649mr5033517b3a.13.1757708462327;
        Fri, 12 Sep 2025 13:21:02 -0700 (PDT)
Received: from [10.110.61.161] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a46eedsm6317156b3a.30.2025.09.12.13.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 13:21:02 -0700 (PDT)
Message-ID: <86bbc54c-3fc9-4c6d-9f93-b684634121bb@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 13:21:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC] PatchWise: Unified Static Analysis for Kernel Development
From: David Gantman <david.gantman@oss.qualcomm.com>
References: <3aa87758-1899-4f7c-aa17-2330e656a467@oss.qualcomm.com>
Content-Language: en-US
To: workflows@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3aa87758-1899-4f7c-aa17-2330e656a467@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c480b0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=_2PzejVuNbwBRFFAgkYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: vPzCYpTXIQEa76rOvXm2sF0gDG3iHApb
X-Proofpoint-ORIG-GUID: vPzCYpTXIQEa76rOvXm2sF0gDG3iHApb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfXzTYlqzReo9qo
 R62oEgHzj/0gW3KaTU8NNFbsVOK/v/hiwewQ86/76ZrrsB9hYokibf4bT7FtpFkYxCrthc2GN2U
 v+zO7B4NJcngKGQzDW+uREReZ0GKH0sQE57AgqKXSKBeCBM3b8WPdX6YfdIUn1aHYwA2Zrq9fLw
 wz5QPW4i7NanC/oKZVP/ioXyqME3+8+2I7m+lHuJomXo7uZqz8/iCQgLBZUeEdzKphQ6u5i78xV
 x8hhFkzjOjIypcb+Gxvsr/defml0n95hcL8Yq0L1SrVJI4iaUYB7i3BaM4AhjRXhkSHSvS05CAQ
 qOmirF4yFA7RlvjxX+G4lhUwoGeBiXag7ccifpyWwh/4Nj5vu0BPKBo3ZrOEcDlediRi39zCVzM
 sILLS0eZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

Kernel developers and maintainers often need to manually run
multiple static analysis tools (checkpatch, coccicheck, sparse,
dt_binding_check, dtbs_check, etc.) and create custom scripts to
consolidate results. This leads to:

- Inconsistent testing environments across different developers
- Time spent writing and maintaining custom integration scripts
- Missed issues due to incomplete tool coverage
- Difficulty in reproducing analysis results

I'd like to introduce PatchWise, a tool designed to address this
fragmentation and manual orchestration of static analysis tools. I'm
seeking feedback from the community on this approach and suggestions for
how it could better serve kernel developers and maintainers.

Key features (All Optional and Configurable):
- Unified interface for checkpatch, coccicheck, sparse,
dt_binding_check, dtbs_check
- Docker-based execution for consistent, reproducible environments
- Simple installation and usage: `$ pip install patchwise` then `$
patchwise` in your kernel tree root
- Allows selective review execution (e.g., `$ patchwise --reviews
checkpatch sparse`)
- Supports both individual commits and commit ranges

Optional AI-Powered Review Features:
PatchWise also includes optional AI-based code review capabilities that
aim to overcome a key limitation in automated patch review: limited
context. When enabled, the tool uses Language Server Protocol (LSP)
integration with clangd to:

- Generate compile_commands.json for accurate code understanding
- Fetch relevant function definitions, struct declarations, and related code
- Provide context-aware feedback rather than superficial pattern matching
- Support multiple LLM providers (OpenAI, etc.)

Important note: All features including AI code review can be selectively
enabled and disabled based on user preference.

Technical Architecture:
- Python 3.10+ with pip installation
- Docker-based isolation for tool execution
- LSP integration for deep AI code understanding
- YAML-based configuration
- Rich logging and debugging support

Source code and current status: https://github.com/qualcomm/PatchWise

Upcoming improvements include patch series support and Docker-based
dependency management for each tool. Open tasks and planned features are
documented in the GitHub issues for visibility and collaboration/

Feedback Requested:
- Tool Integration: Are there other static analysis tools you'd
like to see supported?
- Workflow Integration: How could PatchWise better fit into your
existing development and review workflows?
- Output Format: What formats would be most useful for your use
cases?
- AI Features: For those interested, how else can AI code review and
commit text analysis be improved?

Try it out:
$ pip install patchwise
$ cd /path/to/your/kernel/tree
$ patchwise  # Analyzes HEAD commit with all available tools
$ patchwise --reviews checkpatch sparse  # Runs only specific tools

The goal is to eliminate the need for custom scripts to consolidate
kernel test tools, while offering optional advanced features for those
who want them.

Thanks,
David

