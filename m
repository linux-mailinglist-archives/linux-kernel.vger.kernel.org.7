Return-Path: <linux-kernel+bounces-860622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99FBF089A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7341189197C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8962F6929;
	Mon, 20 Oct 2025 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="meHkDK4m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C32F5313
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956176; cv=none; b=MYdRhEvpX0oQDWultWsp2N3p5XRf8NTyC8ccBwZxTXMSo5A7fEuUJN9fwRr0Rl+/+orJTOaCAO3/Mas2+R79CLcKPlIksKH8PXopWJ92SV8nhzaShdIaKr6VUAnPUjWMXDTW7kgJgn1VLo1hRUOH7tR5HfObguis7WhvmI7tYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956176; c=relaxed/simple;
	bh=tF962YWxw9azz7dtu4nHl90He2ajjnijFWcFDWZOG94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXl5zNo9aFqOLpfo6pqnnj/ZzCvi1p4um2VtByaJAYNVGUuiBNs+pnTnXEvdene02T5LIZLE/qBU8sltMn8eWQ5ZUFZB+25TlnCr5BN4IzQfOn76cXITj4YMu+gylh0N2BZVsFM81e8Z1oc0xBcneb5cpYwyhp9SH1cjltcjWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=meHkDK4m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JMpaAQ018961
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZOYhimoPa+lnW4TwlcuKOW72gVGLTvjPYcjxCfhdnFY=; b=meHkDK4m84xiKr/R
	jqhEBijt4O8HcU/PQ6SEOvKpGk/GarSBp03r5pNthCzcEal5rZuguJ4R2Q9AHfhM
	35kmYwttLikbdZfVkz2AXQ1xuGI1Ugci2B4i4CLJlIdyAPPZ4HKIu7Oo2AywGeco
	aosv5hrFGmcrPLYlq9tjymJpL3jIy4yHqrzDiDZqqzpJURUSh8iv1iVvTOZvNGt0
	YP9wN1/h+D+LVpJ+lp51nbxsC4OO1OyrYZCuOVGhvOpHwe5pJNb2QOR8FPGuh7pD
	os2s2tCE81f3vGlEHnwcphOt+Ppy6jamTrDdsiiZB8ptQIPtR8ptuiwNVljKEgpu
	DIyh3A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27hvh6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:29:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8910b0fb780so535398685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760956173; x=1761560973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOYhimoPa+lnW4TwlcuKOW72gVGLTvjPYcjxCfhdnFY=;
        b=LrpJpHJNNCgqjpbRmOHXocr5Hc5M2WwofDxvH4JWc+Bnf7iC7ZMnagrZ44lpxdxS4x
         vJv8Hk3bvHsoOgMPTf7uOee2/PTsrdo56qMmSRUXbQnah1aUQDyR4K6YcT3LSoskghcR
         r6PHI6rzzy4ORK0hkteuT4ZlswJucqz7LKpuEqaVEaVl5zrhHXVToplb4TyhLBRteDLk
         v5PeTxPzJKOK5/936pEy3tRJWw262afdcYbGOzgK29xBWy7/LBBWx9T1TA67GxEB2bri
         kHvedNqw9SLazttzSZth6wfWnu7BDR3VRcVAEOTs2CLMji0AcmC2mw3YrIo8uuGh25c0
         lytA==
X-Forwarded-Encrypted: i=1; AJvYcCVVppNkiBAGte2V9ZIwfmTGwrxemywZgvaxxYdh68HPEqH2XqZrvRc9r1YgiJGbwyUUslraEE9nJ5DV0pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxUFjKc/EmTxiL1YXBuE1Q0RlG9GNPGtmqnh2MZ++XSVC3IqF
	85jJLQvfGR8uoFCXowv+//tLzlIEa4knKB1ufTCBLRQDuaOEpEbsqZiAbMK1yNdmdz6ntd2G2K5
	AI5tNqB4aab8gpSF627jPzqIgnTEECgHjhtMWCBE3KcVLihdHNfO3hGfOuN4A/VjBowQ=
X-Gm-Gg: ASbGncsnj0QAqop7X06UrBRIPPsZrOb3Zbjt/+4KRxWAB8I46FeJ378GG7JDZDYGlAE
	GyYlSk+k31AVFjM6/rVtUYaSqBsdZzgB9be8SpC+7KLnibOIoXvAQLty/ZoHKhoutJTcfaxYK7H
	qYeyCV1+9RxkBtaRLibPh0bhm0aqFbjoKDcOq3psLFtlvenZ/8CZxgaZ20HerpjJDdZHbolxSwu
	OO/TEo5idhHXlTNVaUxpSHMEY/gIC7eIiDeuUGb4AHyU2Nq/6ieIyAZlzimLq15Xm7+Nn0EIhAJ
	CT9C4TgU3TSL/GE/0H/ONEU+pL9lHXDFdjO6E8ABXEywC6UXOI/aFOba/95os/bn3ljkZaNK4Jx
	H46VAfI/EzYPaoC0w30sx2883Zw==
X-Received: by 2002:ac8:5881:0:b0:4c3:b7b0:3317 with SMTP id d75a77b69052e-4e89d35c473mr169196811cf.42.1760956172530;
        Mon, 20 Oct 2025 03:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlPMeN8JhZycGRui7S8uzF3Tp8ErxdFS7DePnTDJPvNaEZfwFYGHI+INI+m+Umf5wgVdvE/A==
X-Received: by 2002:ac8:5881:0:b0:4c3:b7b0:3317 with SMTP id d75a77b69052e-4e89d35c473mr169196491cf.42.1760956171904;
        Mon, 20 Oct 2025 03:29:31 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm14830637f8f.28.2025.10.20.03.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 03:29:31 -0700 (PDT)
Message-ID: <cb6642c9-8a96-4843-933d-2321d6873719@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 11:29:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] ASoC: qcom: q6asm: Use guard() for spin locks
To: kernel test robot <lkp@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, perex@perex.cz, tiwai@suse.com,
        srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251017085307.4325-13-srinivas.kandagatla@oss.qualcomm.com>
 <202510191117.BTexj8De-lkp@intel.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <202510191117.BTexj8De-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX4UAXmLWKYHeS
 wa39YanS/c4OvIPHPd2CzNM82FCPMewi2oNqAejny/wkjPIFsgF6i0i0u3hLOV8FKV1DzMG+XQe
 NwAvSpHkrdAMHZpVwp2hWqmOHjFrphjt8lvX5RD9n1vuME+XVsFFUxTyXjRQjQeXVaP0x61BrE8
 rDAJ/Ie7DbpPNxm8SzYAMf6kn9dlQ4s9fVu0JOUmUzCi808F2PIzsTtf6v8fFVuCdFb2STQEtmZ
 30AaolaLZGte48xREjZ3FbRh9HA8xzU/D1aAVJ+5TKmQXyY+yBJwxakVIk7KPQTarxFk3Oe2xEY
 JvlEvKVWllvLQBbV56H9EqkANLOUqpGOpxeKRwJpiiUjAqPInxCmwjq4QgVUFTUtI/86Ef+xGqc
 uxwhSFiUFZDzg5rLUtKDuhBNpA/CdQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f60f0d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=anyJmfQTAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=Pp1kaMlfcpgazL37F3AA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-GUID: 49Snmw0YLdcJ15GugE_t7eiGZBosqpLe
X-Proofpoint-ORIG-GUID: 49Snmw0YLdcJ15GugE_t7eiGZBosqpLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018



On 10/19/25 5:18 AM, kernel test robot wrote:
> Hi Srinivas,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on broonie-sound/for-next]
> [also build test ERROR on linus/master v6.18-rc1 next-20251017]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Srinivas-Kandagatla/ASoC-qdsp6-q6asm-do-not-sleep-while-atomic/20251017-170114
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> patch link:    https://lore.kernel.org/r/20251017085307.4325-13-srinivas.kandagatla%40oss.qualcomm.com
> patch subject: [PATCH 12/12] ASoC: qcom: q6asm: Use guard() for spin locks
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20251019/202510191117.BTexj8De-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510191117.BTexj8De-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510191117.BTexj8De-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    sound/soc/qcom/qdsp6/q6asm.c: In function 'q6asm_stream_callback':
>>> sound/soc/qcom/qdsp6/q6asm.c:687:41: error: 'struct audio_port_data' has no member named 'hw_ptr'
>      687 |                         atomic_set(&port->hw_ptr, token + 1);
>          |                                         ^~
> 
> 
> vim +687 sound/soc/qcom/qdsp6/q6asm.c
> 
>    590	
>    591	static int32_t q6asm_stream_callback(struct apr_device *adev,
>    592					     struct apr_resp_pkt *data,
>    593					     int session_id)
>    594	{
>    595		struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
>    596		struct aprv2_ibasic_rsp_result_t *result;
>    597		struct apr_hdr *hdr = &data->hdr;
>    598		struct audio_port_data *port;
>    599		struct audio_client *ac;
>    600		uint32_t client_event = 0;
>    601		int ret = 0;
>    602	
>    603		ac = q6asm_get_audio_client(q6asm, session_id);
>    604		if (!ac)/* Audio client might already be freed by now */
>    605			return 0;
>    606	
>    607		result = data->payload;
>    608	
>    609		switch (hdr->opcode) {
>    610		case APR_BASIC_RSP_RESULT:
>    611			switch (result->opcode) {
>    612			case ASM_SESSION_CMD_PAUSE:
>    613				client_event = ASM_CLIENT_EVENT_CMD_PAUSE_DONE;
>    614				break;
>    615			case ASM_SESSION_CMD_SUSPEND:
>    616				client_event = ASM_CLIENT_EVENT_CMD_SUSPEND_DONE;
>    617				break;
>    618			case ASM_STREAM_CMD_FLUSH:
>    619				client_event = ASM_CLIENT_EVENT_CMD_FLUSH_DONE;
>    620				break;
>    621			case ASM_SESSION_CMD_RUN_V2:
>    622				client_event = ASM_CLIENT_EVENT_CMD_RUN_DONE;
>    623				break;
>    624			case ASM_STREAM_CMD_CLOSE:
>    625				client_event = ASM_CLIENT_EVENT_CMD_CLOSE_DONE;
>    626				break;
>    627			case ASM_STREAM_CMD_FLUSH_READBUFS:
>    628				client_event = ASM_CLIENT_EVENT_CMD_OUT_FLUSH_DONE;
>    629				break;
>    630			case ASM_STREAM_CMD_OPEN_WRITE_V3:
>    631			case ASM_STREAM_CMD_OPEN_READ_V3:
>    632			case ASM_STREAM_CMD_OPEN_READWRITE_V2:
>    633			case ASM_STREAM_CMD_SET_ENCDEC_PARAM:
>    634			case ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2:
>    635			case ASM_DATA_CMD_REMOVE_INITIAL_SILENCE:
>    636			case ASM_DATA_CMD_REMOVE_TRAILING_SILENCE:
>    637				if (result->status != 0) {
>    638					dev_err(ac->dev,
>    639						"cmd = 0x%x returned error = 0x%x\n",
>    640						result->opcode, result->status);
>    641					ac->result = *result;
>    642					wake_up(&ac->cmd_wait);
>    643					ret = 0;
>    644					goto done;
>    645				}
>    646				break;
>    647			default:
>    648				dev_err(ac->dev, "command[0x%x] not expecting rsp\n",
>    649					result->opcode);
>    650				break;
>    651			}
>    652	
>    653			ac->result = *result;
>    654			wake_up(&ac->cmd_wait);
>    655	
>    656			if (ac->cb)
>    657				ac->cb(client_event, hdr->token,
>    658				       data->payload, ac->priv);
>    659	
>    660			ret = 0;
>    661			goto done;
>    662	
>    663		case ASM_DATA_EVENT_WRITE_DONE_V2:
>    664			client_event = ASM_CLIENT_EVENT_DATA_WRITE_DONE;
>    665			if (ac->io_mode & ASM_SYNC_IO_MODE) {
>    666				phys_addr_t phys;
>    667				int token = hdr->token & ASM_WRITE_TOKEN_MASK;
>    668	
>    669				guard(spinlock_irqsave)(&ac->lock);
>    670	
>    671				port =  &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
>    672	
>    673				if (!port->buf) {
>    674					ret = 0;
>    675					goto done;
>    676				}
>    677	
>    678				phys = port->buf[token].phys;
>    679	
>    680				if (lower_32_bits(phys) != result->opcode ||
>    681				    upper_32_bits(phys) != result->status) {
>    682					dev_err(ac->dev, "Expected addr %pa\n",
>    683						&port->buf[token].phys);
>    684					ret = -EINVAL;
>    685					goto done;
>    686				}
>  > 687				atomic_set(&port->hw_ptr, token + 1);

Ah.. looks like left over from adsp patches

will remove this and send a v2.

--srini>    688			}
>    689			break;
>    690		case ASM_DATA_EVENT_READ_DONE_V2:
>    691			client_event = ASM_CLIENT_EVENT_DATA_READ_DONE;
>    692			if (ac->io_mode & ASM_SYNC_IO_MODE) {
>    693				struct asm_data_cmd_read_v2_done *done = data->payload;
>    694				phys_addr_t phys;
>    695	
>    696				guard(spinlock_irqsave)(&ac->lock);
>    697				port =  &ac->port[SNDRV_PCM_STREAM_CAPTURE];
>    698				if (!port->buf) {
>    699					ret = 0;
>    700					goto done;
>    701				}
>    702	
>    703				phys = port->buf[hdr->token].phys;
>    704	
>    705				if (upper_32_bits(phys) != done->buf_addr_msw ||
>    706				    lower_32_bits(phys) != done->buf_addr_lsw) {
>    707					dev_err(ac->dev, "Expected addr %pa %08x-%08x\n",
>    708						&port->buf[hdr->token].phys,
>    709						done->buf_addr_lsw,
>    710						done->buf_addr_msw);
>    711					ret = -EINVAL;
>    712					goto done;
>    713				}
>    714			}
>    715	
>    716			break;
>    717		case ASM_DATA_EVENT_RENDERED_EOS:
>    718			client_event = ASM_CLIENT_EVENT_CMD_EOS_DONE;
>    719			break;
>    720		}
>    721	
>    722		if (ac->cb)
>    723			ac->cb(client_event, hdr->token, data->payload, ac->priv);
>    724	
>    725	done:
>    726		kref_put(&ac->refcount, q6asm_audio_client_release);
>    727		return ret;
>    728	}
>    729	
> 


