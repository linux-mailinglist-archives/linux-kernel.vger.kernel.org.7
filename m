Return-Path: <linux-kernel+bounces-843701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB4BC0084
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 04:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B48344E4799
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 02:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9C1DF759;
	Tue,  7 Oct 2025 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bcd63eLL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A232AD2F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759804430; cv=none; b=mKJmuFs4kyAgBoeBd5q9D9A9vfQtj+EQEqnDJdAwoc37/5xTlm+HdrrUyaw8rFzSVVJiy66KjEoos+XkdALek1lsB9waA0SVJKbLvRbq0BcRmZs8EVLtQ5WlQqGqQauQyLV960fg45tjX6jEvDoqSuJeq2qT3+p2XxNiZKYUt1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759804430; c=relaxed/simple;
	bh=Dlcnn7y3HlTxqYtAbXosZmFmnaZZi+s6TuVywlg5AaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dLHnfpbICJpT1JQRWpVWDDLJ66Dzxhy3kxbKSqwJAVttM9vWIbuDNYZrj5nUmhl/bZ5nM5gGDlkT+JVIfHDdikRawjDU3ghUL2ygkENk3akNCji6UN3+McsbVZSMYuZvkNUAf/oQzVeWn4KAah1C9x7HZImXZLFcmZie4b4mW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bcd63eLL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FBQ2w024168
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 02:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7XSY4z7nlmBoPCLNtNQ+8rowUkAIu3i0gAH
	G6gd+0F4=; b=Bcd63eLLddyDJ6CXgrewHmny6+WzK8fp1RTQ/Aeio+5ycL19ssl
	GQEwaFgE9GXFYQfpfkd4E7a1N9+ncetEynzvVfMM2Y1rS+nrIqKvycmsnfdWqAsv
	wosf7clUQAVKyjUgHHkPQ0e4AGU//v6AfBr90z5m3DC5tVt31nh38WFHEsiF1owB
	+nzcykzvi148ojVoJLYJASL+HkT/z0oopKMvf+fyFteuSSXfRSmJZZ8khrRVMqBL
	tzGx3BAzTvQ5H1mu1CaqrTBLEjyH/ItrEybhNkeJRHp6rq38+pqNmy/ARBbZWSNm
	mkpJd886vbRDEcVHf5PdEAp0oocBXneNiww==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mg6a9gga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:33:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28e538b5f23so61100685ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 19:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759804427; x=1760409227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7XSY4z7nlmBoPCLNtNQ+8rowUkAIu3i0gAHG6gd+0F4=;
        b=dwlijLkNb2Nh3f4rThnhdrD1p7OfAAIfbGBDReApNTc/YJakdNCfkklJ9OFi6Lz/U5
         ibIwmlAT9/ofyjrypZAriclFkRGcsJ5ARmTGmYclAaSYrxZCs/rFhYKHbLnqQLzo9OxP
         8aJkKyB+/cLfBPCjUGUe1XZwIozayVe7qmZc5aX5hb+ryvCsYEpyW/Yqd7sy3yZuphq5
         YSyd4YwNBC4QJ3auwEHTFqsKP3DBce67FFQcE+QTOHlzai8a4zTXNYxn7hhlxSvl6QxT
         9NRs0kCi+9eQDU43Rvlg2j8rlp9RH1ysAc09t8V0Fub4EeCHCHAe/UWii/+lx8xrUkl9
         ebCA==
X-Forwarded-Encrypted: i=1; AJvYcCW3QqfjExG5ux8T+UvGR/RqWqBMn2PqgGNTvKGknWOSIRSvAtwd133VXEdJFSGTnpDKXpnxd0kSkrvJSpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32YLlEd3tD5YEIRtdl2S8QMolTwfGp0lsK2GdQ78I4IXT/8ry
	ud9jq5xO4YNMGIK3TmllPOQenhoHXTE1FC+N47xBZgnO8pMlYG9ZM6+tXDI26Ok3nCyefjk8raw
	qfZK/ntbhI4HteM1PGouezom6sUCPibRNMh0umeUO2d2xe5CTJRUF3LmOy2xNlBpnDR0=
X-Gm-Gg: ASbGnctdJ3CSbaFapZyyxOPTt7cTH0FIBFWDLTQM9LbmOEpJOV+39lYHR05FxYoalyK
	qGNEixHqVXoFEA0B67GbokFU3JWwab9FD8/Azp3ObzVxRa8FClKI9Pb6/3SPte+xkLxrg1VVN5E
	XmfiQaFj+HFZ5Za/TwtwiQHpc8DsasbtqH+Mo4WFb9FVnClmOTIQPNCLNLDazJQFfZcEb740PX9
	4VpSzDzRwmRNXGpozNbWHvEChvlo5jkvu/EmvriHkSQhTrgvOL06citHnVobjZ+CPqKAWzcU+k+
	Jp3FtkBM7Pbh5If8U4bXubezsoCH7bSdiJKrkeS0ss78/Qq4dBEMT3fiI1QWAq/DTRX7IuHrfUp
	VU3EfCQ==
X-Received: by 2002:a17:903:3504:b0:24a:fab6:d15a with SMTP id d9443c01a7336-28e9a5665f8mr169858275ad.20.1759804426898;
        Mon, 06 Oct 2025 19:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiig/p1KQze92yCEITwhtnQai6O3T2aDxdUHjAMcQsNgWMdH7TrKomEar5i3ANE9//H9BSuw==
X-Received: by 2002:a17:903:3504:b0:24a:fab6:d15a with SMTP id d9443c01a7336-28e9a5665f8mr169857945ad.20.1759804426362;
        Mon, 06 Oct 2025 19:33:46 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba25asm147726755ad.87.2025.10.06.19.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 19:33:46 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com, stable@vger.kernel.org
Subject: [PATCH v1] ASoC: soc-pcm: Fix mute and unmute control for non-dynamic DAI links
Date: Tue,  7 Oct 2025 08:03:25 +0530
Message-Id: <20251007023325.853640-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QtdTHFyd c=1 sm=1 tr=0 ts=68e47c0b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3uxOjINHiGvl1vUfC3YA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: PEyaYVP_6x34oh7rOul3mttA0q7_aNpd
X-Proofpoint-GUID: PEyaYVP_6x34oh7rOul3mttA0q7_aNpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMSBTYWx0ZWRfX/J6JeezVHdUc
 CC9vhm5xATN8QsT1V/FrPP/3wTmMwbjEuW/EX5hO3vYFmnYtFs9wo5+C1sEtMWw2H9mE56+SMkZ
 wRPtobqQkJ6QkYrwuYPWQyQ3iwdMSkJqMk3+CX3o8drp35IYRvVPL8tvd6ByOOcZx8YkEJjo9ND
 V3Zll9B+XCoV5Km07XASCfCHlQKEiEOizQ+KnEAEnXvFqwjZFru5PxXWBdu3EhoJ9WA9srqMZNS
 jwrecDL9qRFzxQ7GlJUwsnRdrCtjpcYM2/Xn2vEoILDz6dfc08C83AVoJ9ekc/20M3QgmgTU+Mo
 jGCPWdtBN89DaYl7X8wl84OpweL/nlY8v034GC0nwhjnhL/rI4dweutBAlZifLcvv9onSK+bXOm
 9EW9QwtY5vTljYh3eonkKC83P381UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060121

In setups where the same codec DAI is reused across multiple DAI
links, mute controls via `snd_soc_dai_digital_mute()` is skipped for
non-dynamic links. The trigger operations are not invoked when
`dai_link->dynamic == 0`, and mute controls is currently conditioned
only on `snd_soc_dai_mute_is_ctrled_at_trigger()`. This patch ensures
that mute and unmute is applied explicitly for non-dynamic links.

Fixes: f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2c21fd528afd..4ed829b49bc2 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -949,7 +949,7 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
 			SND_SOC_DAPM_STREAM_START);
 
 	for_each_rtd_dais(rtd, i, dai) {
-		if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
+		if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd->dai_link->dynamic)
 			snd_soc_dai_digital_mute(dai, 0, substream->stream);
 	}
 
@@ -1007,7 +1007,7 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
 			soc_pcm_set_dai_params(dai, NULL);
 
 		if (snd_soc_dai_stream_active(dai, substream->stream) == 1) {
-			if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
+			if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd->dai_link->dynamic)
 				snd_soc_dai_digital_mute(dai, 1, substream->stream);
 		}
 	}
-- 
2.34.1


