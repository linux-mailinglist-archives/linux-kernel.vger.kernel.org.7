Return-Path: <linux-kernel+bounces-761255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1989B1F62B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 22:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678063BB048
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1E8275B17;
	Sat,  9 Aug 2025 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DulfGvfP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D86F219A79
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754770954; cv=none; b=WGpMRmbFctN6BjUYsKbG/nkrmB15b04rIi4lka1bHl4wxO5BUUzPh4X3vfyuicfjnHRQu3Ype/B8p+Ekjl43hvvp1HY3ECiDuYx8bCFHVlCVe96Wa5EcgVdDy5Qg7KEgUyxw03SagR4ov+yz/0O3FNXrcofwgn747XVSip/FrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754770954; c=relaxed/simple;
	bh=e7omdP/1q+AA9HsQYaPR6JWVQM8GZagipGYppdun0eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ3/3t8CMc+wcKNFQ+iOoBrZeUbtFVGUPE5IIGJn6U9Sx7KO0t1OwIx3FQdi8G9nDmTja+sJUg+q8Wt2B5YSWjQc8jJIJVdtScn8X4G25v5rYPgSA1L6iUiWs2FtLeUfr+q5DohulcyTX0DHlWdf7/p+b8pbc8+tG6Igaq4i9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DulfGvfP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754770953; x=1786306953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e7omdP/1q+AA9HsQYaPR6JWVQM8GZagipGYppdun0eQ=;
  b=DulfGvfPGEu4qk0kQ1d5GacitTVvTlOCpQEjMx30LDXs/aHjpMuQd64W
   PbftXu/ZpsrgqTbMEzu6zouJKw2T3zPDR/X2siu+zWahTD6X8Ev3vIXT+
   9NSrFHDI+6aaaH9IzO6x95UUOoxoksc6kRF3TDF+gTKViXSohCGWQCHEb
   vqKfKjISX0k1Z/jKcauTCYOBSHt0pdD60wt21iJl/wVLMA8XyN0Azl3K9
   g8hEQ/LLSlQ95Zqp1CL6O07+twmkB8uIFkmKDHoahRhXIfh4JQf+OubGL
   zIW+IjShYu6aKKrXdeexYvlotVOXmScg/1TujbRKbZcz8Y/M05K5aWLJA
   g==;
X-CSE-ConnectionGUID: eXlSmhqkQPiPr/iMHZDV/g==
X-CSE-MsgGUID: ZbjIEPViSGefglT4M1qTzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11516"; a="57225632"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57225632"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 13:22:32 -0700
X-CSE-ConnectionGUID: HyMUmsd4RsqNnaGCA3D/pA==
X-CSE-MsgGUID: rPdiGR7KRF+MSZi1r65vIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="164811004"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2025 13:22:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukq5D-00052e-0w;
	Sat, 09 Aug 2025 20:22:27 +0000
Date: Sun, 10 Aug 2025 04:22:02 +0800
From: kernel test robot <lkp@intel.com>
To: Yao-Wen Chang <changyaowen19980629@gmail.com>,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Yao-Wen-Chang <changyaowen19980629@gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: refactor code for style compliance
Message-ID: <202508100445.F41ihSl4-lkp@intel.com>
References: <20250809182835.863172-1-changyaowen19980629@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809182835.863172-1-changyaowen19980629@gmail.com>

Hi Yao-Wen,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Yao-Wen-Chang/staging-rtl8723bs-refactor-code-for-style-compliance/20250810-023733
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250809182835.863172-1-changyaowen19980629%40gmail.com
patch subject: [PATCH] staging: rtl8723bs: refactor code for style compliance
config: x86_64-buildonly-randconfig-006-20250810 (https://download.01.org/0day-ci/archive/20250810/202508100445.F41ihSl4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250810/202508100445.F41ihSl4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508100445.F41ihSl4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/rtl8723bs/core/rtw_cmd.c:715:8: error: use of undeclared identifier 'ndis80211_AP_mode'; did you mean 'Ndis802_11APMode'?
     715 |                 case ndis80211_AP_mode:
         |                      ^~~~~~~~~~~~~~~~~
         |                      Ndis802_11APMode
   drivers/staging/rtl8723bs/include/wlan_bssdef.h:51:2: note: 'Ndis802_11APMode' declared here
      51 |         Ndis802_11APMode,
         |         ^
>> drivers/staging/rtl8723bs/core/rtw_cmd.c:778:31: error: no member named 'dot11_privacy_algrthm' in 'struct security_priv'; did you mean 'dot11PrivacyAlgrthm'?
     778 |                 if ((padapter->securitypriv.dot11_privacy_algrthm != _WEP40_) &&
         |                                             ^~~~~~~~~~~~~~~~~~~~~
         |                                             dot11PrivacyAlgrthm
   drivers/staging/rtl8723bs/include/rtw_security.h:95:8: note: 'dot11PrivacyAlgrthm' declared here
      95 |         u32   dot11PrivacyAlgrthm;      /*  This specify the privacy for shared auth. algorithm. */
         |               ^
   drivers/staging/rtl8723bs/core/rtw_cmd.c:779:31: error: no member named 'dot11_privacy_algrthm' in 'struct security_priv'; did you mean 'dot11PrivacyAlgrthm'?
     779 |                     (padapter->securitypriv.dot11_privacy_algrthm != _WEP104_) &&
         |                                             ^~~~~~~~~~~~~~~~~~~~~
         |                                             dot11PrivacyAlgrthm
   drivers/staging/rtl8723bs/include/rtw_security.h:95:8: note: 'dot11PrivacyAlgrthm' declared here
      95 |         u32   dot11PrivacyAlgrthm;      /*  This specify the privacy for shared auth. algorithm. */
         |               ^
   drivers/staging/rtl8723bs/core/rtw_cmd.c:780:31: error: no member named 'dot11_privacy_algrthm' in 'struct security_priv'; did you mean 'dot11PrivacyAlgrthm'?
     780 |                     (padapter->securitypriv.dot11_privacy_algrthm != _TKIP_)) {
         |                                             ^~~~~~~~~~~~~~~~~~~~~
         |                                             dot11PrivacyAlgrthm
   drivers/staging/rtl8723bs/include/rtw_security.h:95:8: note: 'dot11PrivacyAlgrthm' declared here
      95 |         u32   dot11PrivacyAlgrthm;      /*  This specify the privacy for shared auth. algorithm. */
         |               ^
   drivers/staging/rtl8723bs/core/rtw_cmd.c:909:62: error: no member named 'dot11_privacy_algrthm' in 'struct security_priv'; did you mean 'dot11PrivacyAlgrthm'?
     909 |                 psetstakey_para->algorithm = (unsigned char)psecuritypriv->dot11_privacy_algrthm;
         |                                                                            ^~~~~~~~~~~~~~~~~~~~~
         |                                                                            dot11PrivacyAlgrthm
   drivers/staging/rtl8723bs/include/rtw_security.h:95:8: note: 'dot11PrivacyAlgrthm' declared here
      95 |         u32   dot11PrivacyAlgrthm;      /*  This specify the privacy for shared auth. algorithm. */
         |               ^
   5 errors generated.


vim +715 drivers/staging/rtl8723bs/core/rtw_cmd.c

   676	
   677	u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
   678	{
   679		u8 res = _SUCCESS;
   680		uint	t_len = 0;
   681		struct wlan_bssid_ex *psecnetwork;
   682		struct cmd_obj *pcmd;
   683		struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
   684		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
   685		struct qos_priv *pqospriv = &pmlmepriv->qospriv;
   686		struct security_priv *psecuritypriv = &padapter->securitypriv;
   687		struct registry_priv *pregistrypriv = &padapter->registrypriv;
   688		struct ht_priv *phtpriv = &pmlmepriv->htpriv;
   689		enum ndis_802_11_network_infrastructure ndis_network_mode =
   690			pnetwork->network.infrastructure_mode;
   691		struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
   692		struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
   693		u32 tmp_len;
   694		u8 *ptmp = NULL;
   695	
   696		pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
   697		if (!pcmd) {
   698			res = _FAIL;
   699			goto exit;
   700		}
   701		/* for ies is fix buf size */
   702		t_len = sizeof(struct wlan_bssid_ex);
   703	
   704		/* for hidden ap to set fw_state here */
   705		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE) != true) {
   706			switch (ndis_network_mode) {
   707			case Ndis802_11IBSS:
   708				set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
   709				break;
   710	
   711			case Ndis802_11Infrastructure:
   712				set_fwstate(pmlmepriv, WIFI_STATION_STATE);
   713				break;
   714	
 > 715			case ndis80211_AP_mode:
   716			case Ndis802_11AutoUnknown:
   717			case Ndis802_11InfrastructureMax:
   718				break;
   719			}
   720		}
   721	
   722		psecnetwork = (struct wlan_bssid_ex *)&psecuritypriv->sec_bss;
   723	
   724		memset(psecnetwork, 0, t_len);
   725	
   726		memcpy(psecnetwork, &pnetwork->network, get_wlan_bssid_ex_sz(&pnetwork->network));
   727	
   728		psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->ie_length;
   729	
   730		if ((psecnetwork->ie_length - 12) < (256 - 1))
   731			memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12],
   732			       psecnetwork->ie_length - 12);
   733		else
   734			memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], (256 - 1));
   735	
   736		psecnetwork->ie_length = 0;
   737		/*  Added by Albert 2009/02/18 */
   738		/*  If the driver wants to use the bssid to create the connection. */
   739		/*  If not,  we have to copy the connecting AP's MAC address to it so that */
   740		/*  the driver just has the bssid information for PMKIDList searching. */
   741	
   742		if (!pmlmepriv->assoc_by_bssid)
   743			memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.mac_address[0], ETH_ALEN);
   744	
   745		psecnetwork->ie_length = rtw_restruct_sec_ie(padapter,
   746							     &pnetwork->network.ies[0],
   747							     &psecnetwork->ies[0],
   748							     pnetwork->network.ie_length);
   749	
   750		pqospriv->qos_option = 0;
   751	
   752		if (pregistrypriv->wmm_enable) {
   753			tmp_len = rtw_restruct_wmm_ie(padapter,
   754						      &pnetwork->network.ies[0],
   755						      &psecnetwork->ies[0],
   756						      pnetwork->network.ie_length,
   757						      psecnetwork->ie_length);
   758	
   759			if (psecnetwork->ie_length != tmp_len) {
   760				psecnetwork->ie_length = tmp_len;
   761				pqospriv->qos_option = 1; /* There is WMM IE in this corresp. beacon */
   762			} else {
   763				pqospriv->qos_option = 0;/* There is no WMM IE in this corresp. beacon */
   764			}
   765		}
   766	
   767		phtpriv->ht_option = false;
   768		ptmp = rtw_get_ie(&pnetwork->network.ies[12],
   769				  WLAN_EID_HT_CAPABILITY,
   770				  &tmp_len,
   771				  pnetwork->network.ie_length - 12);
   772		if (pregistrypriv->ht_enable && ptmp && tmp_len > 0) {
   773			/* Added by Albert 2010/06/23
   774			 * For the WEP mode, we will use the bg mode to
   775			 * do the connection to avoid some IOT issue.
   776			 * Especially for Realtek 8192u SoftAP.
   777			 */
 > 778			if ((padapter->securitypriv.dot11_privacy_algrthm != _WEP40_) &&
   779			    (padapter->securitypriv.dot11_privacy_algrthm != _WEP104_) &&
   780			    (padapter->securitypriv.dot11_privacy_algrthm != _TKIP_)) {
   781				rtw_ht_use_default_setting(padapter);
   782	
   783				rtw_build_wmm_ie_ht(padapter,
   784						    &psecnetwork->ies[12],
   785						    &psecnetwork->ie_length);
   786	
   787				/* rtw_restructure_ht_ie */
   788				rtw_restructure_ht_ie(padapter,
   789						      &pnetwork->network.ies[12],
   790						      &psecnetwork->ies[0],
   791						      pnetwork->network.ie_length - 12,
   792						      &psecnetwork->ie_length,
   793						      pnetwork->network.configuration.ds_config);
   794			}
   795		}
   796	
   797		rtw_append_exented_cap(padapter, &psecnetwork->ies[0], &psecnetwork->ie_length);
   798	
   799		pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->network.ies,
   800							    pnetwork->network.ie_length);
   801	
   802		pcmd->cmdsz = get_wlan_bssid_ex_sz(psecnetwork);/* get cmdsz before endian conversion */
   803	
   804		INIT_LIST_HEAD(&pcmd->list);
   805		pcmd->cmdcode = _JoinBss_CMD_;/* GEN_CMD_CODE(_JoinBss) */
   806		pcmd->parmbuf = (unsigned char *)psecnetwork;
   807		pcmd->rsp = NULL;
   808		pcmd->rspsz = 0;
   809	
   810		res = rtw_enqueue_cmd(pcmdpriv, pcmd);
   811	
   812	exit:
   813		return res;
   814	}
   815	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

