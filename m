Return-Path: <linux-kernel+bounces-864715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26EBFB664
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07D54502CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FD32F2603;
	Wed, 22 Oct 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmPg1YXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AEE3161AF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128781; cv=none; b=WZLmiOSxz6bPZxmTyXJ06r3JEpuMVcEbE4+gJWyc9w+F0109qABvgGC2gh3phHcP5m/R5aa6aYOrsQHF4Ocldx+s9123wYxLq3HE7nEzO7efO8uThvgBbX7u3sBaNUbIaEr63hxeJ+OEuHMqOQclkZc1B5LOY3JO4xTn8ijd34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128781; c=relaxed/simple;
	bh=OVmChDHTMfQlmcWWyGsPYRn1brx0pLL8vQD4pcIy+Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF/Wq2SH/kNnhGumV+mLAFoMBgtVoxgjrp4xppzlnSuZhUa4dAMT9QWn+HQENijLAKzZwNGtBa1tblhYn7ONgNmRl44U4ZZEa6AFH1o+lVQugeAz6gXbLTynDikVY6cANlUQ5OGPuB+47uufSbCRG4IUhGA3kjPjnz6ULh4tzbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmPg1YXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498F9C4CEE7;
	Wed, 22 Oct 2025 10:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761128780;
	bh=OVmChDHTMfQlmcWWyGsPYRn1brx0pLL8vQD4pcIy+Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmPg1YXAqTxVzSQFFvzOxiMNj5d45opH/DiXFPkttZS4IxJhaX8PwsZ211SqUXcWA
	 r/9Dw7vsV3zAdbmdKpQVvo6LDFEkyLPZJJ/LGXi8n8QZ0CmVUwLqHq8TBOVW3gB7Ol
	 /bZeOCI4xPihbO9KYqw0l5rt1pzGCuGJDxNKAPIY5Aope6u2/mBcjGw0wreiFuFjUO
	 FtznVUPMPbVdoiH4u0enoTHXTvcTOfD7nSakmfPDa2teacjFj2kV5MJMaOH8KWDc5Y
	 2TWRZ2UDEDV1E3ONUul0HUVT0ilmRmVfZ6n05W/xsRIGeU3NCNIZO/SntDLCaAYmHX
	 f66B46FYVj6Yg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 69C22F40066;
	Wed, 22 Oct 2025 06:26:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 22 Oct 2025 06:26:19 -0400
X-ME-Sender: <xms:S7H4aIoB8wQKpHgkXcd57tWSTYvE8sAqGxtTzs-1lD-yVTOsNB1xRg>
    <xme:S7H4aMHp69hVxYgYFP_yIGoxXhztgyX59qVIqBCdZ1ByprJYv1HWyiV5a5VQoyOOY
    68t4xgHcaWbF-h44ais5_evj_OFnJpg7gxKMZqGIH-T2GYtcxlbVLRA>
X-ME-Received: <xmr:S7H4aNKoskpV_4H6dbq8AlspJOVyUJ4TUTUU05hRrN2xahV5Xt-sFUe_twmeMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrhh
    grnhhsvghnsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqtghotghosehl
    ihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoh
    epmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedr
    uggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtg
    homh
X-ME-Proxy: <xmx:S7H4aBgmm3ml89hEl4Ym0DktI9cm5zPhrEqr4E8EbKbnUfZMorCk8g>
    <xmx:S7H4aH4gLUR1iwXLpYEPEPFZiywEz2f0q7UET_5K2P3O5LLgDMfDbw>
    <xmx:S7H4aGM77rvtP9wKxynIwPvmr-quovzIym8Wo8NK78oa2eni4bmCtw>
    <xmx:S7H4aGek3_D4E6Bx-dYKlckVif9uFw6tBcE7RnpWoWKy7aI4fKE7wg>
    <xmx:S7H4aB3p8KEHFvrufDmK2DTOgJt-NWlAXK32lz6BII3YTy0mMZNHc1yC>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 06:26:18 -0400 (EDT)
Date: Wed, 22 Oct 2025 11:26:16 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Kai Huang <kai.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Retrieve TDX module version
Message-ID: <nfos7qsdendp45avmlpbftmekckewwvbb6romybh2dnbvomfee@a5lqto3xkeak>
References: <20251001022309.277238-1-chao.gao@intel.com>
 <20251001022309.277238-2-chao.gao@intel.com>
 <934568ea-b9a0-4ea8-b62f-2edfd2e64f9f@intel.com>
 <aPiNy8Q3uPrlVlug@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPiNy8Q3uPrlVlug@intel.com>

On Wed, Oct 22, 2025 at 03:54:51PM +0800, Chao Gao wrote:
> On Wed, Oct 01, 2025 at 08:15:46AM -0700, Dave Hansen wrote:
> >On 9/30/25 19:22, Chao Gao wrote:
> >> +	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
> >> +		sysinfo_version->minor_version = val;
> >> +	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
> >> +		sysinfo_version->major_version = val;
> >> +	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
> >> +		sysinfo_version->update_version = val;
> >
> >Heh, how long does this take in practice to get 6 bytes of data out of
> >the module?
> 
> ~8us. And the whole metadata reading process (i.e., get_tdx_sys_info()) takes
> ~113us.
> 
> >When is the point that we move  over to TDH.SYS.RDALL?
> 
> TDH.SYS.RDALL takes ~16us.
> 
> I'm uncertain whether the saved CPU time of ~100us justifies implementing
> TDH.SYS.RDALL.
> 
> TDH.SYS.RDALL returns all metadata as a list of arrays, requiring the kernel to
> parse this structure and iterate through all fields.
> 
> One advantage of TDH.SYS.RDALL is that it eliminates the need to check field
> existence before reading, since it simply dumps all available fields rather
> than targeting specific ones. For example, TDH.SYS.RDALL removes the need for
> the tdx_supports_ABC() check:
> 
> 	in the DPAMT series:
> 
> 	+	if (!ret && tdx_supports_dynamic_pamt(&tdx_sysinfo) &&
> 	+	    !(ret = read_sys_metadata_field(0x9100000100000013, &val)))
> 	+		sysinfo_tdmr->pamt_page_bitmap_entry_bits = val;
> 
> 	in the TDX Module update series:
> 
> 	+	if (tdx_supports_runtime_update(&tdx_sysinfo) &&
> 	+	    !(ret = read_sys_metadata_field(0x8900000100000000, &val)))
> 	+		sysinfo_handoff->module_hv = val;
> 
> While iterating through the array list adds some complexity, this is a one-time
> cost. Once the loop structure is in place, adding new fields only requires
> inserting a "switch-case" clause within the loop.
> 
> Please see the draft code below. If TDH.SYS.RDALL is the right direction, I can
> refine the code and submit a formal patch series.

I don't hate it. Seems more scalable than current approach.

See some comments below.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 128e6ffba736..fa9bb6d47a87 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -226,22 +226,23 @@ static int build_tdx_memlist(struct list_head *tmb_list)
> 	return ret;
>  }
>  
> -static int read_sys_metadata_field(u64 field_id, u64 *data)
> +static int read_sys_metadata_field(u64 *field_id, void *ptr)

Keeping the same name for completely different functionality?

>  {
> 	struct tdx_module_args args = {};
> 	int ret;
>  
> 	/*
> -	 * TDH.SYS.RD -- reads one global metadata field
> -	 *  - RDX (in): the field to read
> -	 *  - R8 (out): the field data
> +	 * TDH.SYS.RDALL -- reads all global metadata fields
> +	 *  - RDX (in): the physical address of the buffer to store
> +	 *  - R8 (in/out): the initial field ID to read (in) and
> +	 *		   the next field ID to read (out).
> 	 */
> -	args.rdx = field_id;
> -	ret = seamcall_prerr_ret(TDH_SYS_RD, &args);
> +	args.rdx = __pa(ptr);

Maybe take virtual address (unsigned long) of the buffer as an argument
to the function. And use virt_to_phys() here.

This way there's no need in cast on caller side.

> +	args.r8  = *field_id;
> +	ret = seamcall_prerr_ret(TDH_SYS_RDALL, &args);
> 	if (ret)
> 		return ret;
> -
> -	*data = args.r8;
> +	*field_id = args.r8;
>  
> 	return 0;

Hm. Isn't it buggy?

Caller expects to see field_id == -1 to exit loop, but you never set it
in case of an error. It will result in endless loop if error happens not on
the first iteration.

Drop the branch and always return ret.

>  }
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index 1965adb63f1f..44d92047073e 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -42,6 +42,7 @@
>  #define TDH_SYS_RD			34
>  #define TDH_SYS_LP_INIT			35
>  #define TDH_SYS_TDMR_INIT		36
> +#define TDH_SYS_RDALL			37
>  #define TDH_MEM_TRACK			38
>  #define TDH_PHYMEM_CACHE_WB		40
>  #define TDH_PHYMEM_PAGE_WBINVD		41
> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> index 3fdd5cbc21d8..f4b16367ef2f 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> @@ -7,121 +7,177 @@
>   * Include this file to other C file instead.
>   */
>  
> -static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
> +struct md_field_id
>  {
> -	int ret = 0;
> -	u64 val;
> -
> -	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
> -		sysinfo_version->minor_version = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
> -		sysinfo_version->major_version = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
> -		sysinfo_version->update_version = val;
> -
> -	return ret;
> -}
> -
> -static int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
> -{
> -	int ret = 0;
> -	u64 val;
> -
> -	if (!ret && !(ret = read_sys_metadata_field(0x0A00000300000008, &val)))
> -		sysinfo_features->tdx_features0 = val;
> -
> -	return ret;
> -}
> -
> -static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
> +	union {
> +		struct {
> +			u32 field_code;				// Bits 31:0
> +			u32 element_size_code		: 2;	// Bits 33:32
> +			u32 last_element_in_field	: 4;	// Bits 37:34
> +			u32 last_field_in_sequence	: 9;	// Bits 46:38
> +			u32 reserved_1			: 3;	// Bits 49:47
> +			u32 inc_size			: 1;	// Bit 50
> +			u32 write_mask_valid		: 1;	// Bit 51
> +			u32 context_code		: 3;	// Bits 54:52
> +			u32 reserved_2			: 1;	// Bit 55
> +			u32 class_code			: 6;	// Bits 61:56
> +			u32 reserved_3			: 1;	// Bit 62
> +			u32 non_arch			: 1;	// Bit 63
> +		};
> +		u64 raw;
> +	};
> +};
> +struct md_list_header
>  {
> -	int ret = 0;
> -	u64 val;
> -
> -	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000008, &val)))
> -		sysinfo_tdmr->max_tdmrs = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000009, &val)))
> -		sysinfo_tdmr->max_reserved_per_tdmr = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000010, &val)))
> -		sysinfo_tdmr->pamt_4k_entry_size = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000011, &val)))
> -		sysinfo_tdmr->pamt_2m_entry_size = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000012, &val)))
> -		sysinfo_tdmr->pamt_1g_entry_size = val;
> -
> -	return ret;
> -}
> +	u16 list_buff_size;
> +	u16 num_sequences;
> +	u32 reserved;
> +};
>  
> -static int get_tdx_sys_info_td_ctrl(struct tdx_sys_info_td_ctrl *sysinfo_td_ctrl)
> +struct md_sequence
>  {
> -	int ret = 0;
> -	u64 val;
> +	struct md_field_id sequence_header;
> +	u64 element[0];
> +};
> +
> +#define TDX_MD_ID_MINOR_VERSION			0x0800000100000003
> +#define TDX_MD_ID_MAJOR_VERSION			0x0800000100000004
> +#define TDX_MD_ID_UPDATE_VERSION		0x0800000100000005
> +#define TDX_MD_ID_MODULE_HV			0x8900000100000000
> +#define TDX_MD_ID_TDX_FEATURES0			0x0A00000300000008
> +#define TDX_MD_ID_MAX_TDMRS			0x9100000100000008
> +#define TDX_MD_ID_MAX_RESERVED_PER_TDMR		0x9100000100000009
> +#define TDX_MD_ID_PAMT_4K_ENTRY_SIZE		0x9100000100000010
> +#define TDX_MD_ID_PAMT_2M_ENTRY_SIZE		0x9100000100000011
> +#define TDX_MD_ID_PAMT_1G_ENTRY_SIZE		0x9100000100000012
> +#define TDX_MD_ID_TDR_BASE_SIZE			0x9800000100000000
> +#define TDX_MD_ID_TDCS_BASE_SIZE		0x9800000100000100
> +#define TDX_MD_ID_TDVPS_BASE_SIZE		0x9800000100000200
> +#define TDX_MD_ID_ATTRIBUTES_FIXED0		0x1900000300000000
> +#define TDX_MD_ID_ATTRIBUTES_FIXED1		0x1900000300000001
> +#define TDX_MD_ID_XFAM_FIXED0			0x1900000300000002
> +#define TDX_MD_ID_XFAM_FIXED1			0x1900000300000003
> +#define TDX_MD_ID_NUM_CPUID_CONFIG		0x9900000100000004
> +#define TDX_MD_ID_MAX_VCPUS_PER_TD		0x9900000100000008
> +#define TDX_MD_ID_CPUID_CONFIG_LEAVES		0x9900000300000400
> +#define TDX_MD_ID_CPUID_CONFIG_VALUES		0x9900000300000500
>  
> -	if (!ret && !(ret = read_sys_metadata_field(0x9800000100000000, &val)))
> -		sysinfo_td_ctrl->tdr_base_size = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x9800000100000100, &val)))
> -		sysinfo_td_ctrl->tdcs_base_size = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x9800000100000200, &val)))
> -		sysinfo_td_ctrl->tdvps_base_size = val;
> -
> -	return ret;
> -}
> +/*
> + * Extract CLASS_CODE (bits 61:56), CONTEXT_CODE(bits 54:52),
> + * FIELD_CODE(bits 23:0) from metadata IDs. Other bits in metadata IDs
> + * cannot be used for comparison.
> + */
> +#define TDX_MD_ID_MASK				0x3f70000000ffffff
>  
> -static int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf)
> +static void parse_md_sequence(struct md_sequence *sequence, struct tdx_sys_info *sysinfo)
>  {
> -	int ret = 0;
> -	u64 val;
> +	u32 num_elements = (sequence->sequence_header.last_element_in_field + 1) *
> +			   (sequence->sequence_header.last_field_in_sequence + 1);
> +	u64 base_id = sequence->sequence_header.raw & TDX_MD_ID_MASK;
> +	u64 field_id;
> +	u64 *data;
> 	int i, j;
>  
> -	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000000, &val)))
> -		sysinfo_td_conf->attributes_fixed0 = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000001, &val)))
> -		sysinfo_td_conf->attributes_fixed1 = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000002, &val)))
> -		sysinfo_td_conf->xfam_fixed0 = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000003, &val)))
> -		sysinfo_td_conf->xfam_fixed1 = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x9900000100000004, &val)))
> -		sysinfo_td_conf->num_cpuid_config = val;
> -	if (!ret && !(ret = read_sys_metadata_field(0x9900000100000008, &val)))
> -		sysinfo_td_conf->max_vcpus_per_td = val;
> -	if (sysinfo_td_conf->num_cpuid_config > ARRAY_SIZE(sysinfo_td_conf->cpuid_config_leaves))
> -		return -EINVAL;
> -	for (i = 0; i < sysinfo_td_conf->num_cpuid_config; i++)
> -		if (!ret && !(ret = read_sys_metadata_field(0x9900000300000400 + i, &val)))
> -			sysinfo_td_conf->cpuid_config_leaves[i] = val;
> -	if (sysinfo_td_conf->num_cpuid_config > ARRAY_SIZE(sysinfo_td_conf->cpuid_config_values))
> -		return -EINVAL;
> -	for (i = 0; i < sysinfo_td_conf->num_cpuid_config; i++)
> -		for (j = 0; j < 2; j++)
> -			if (!ret && !(ret = read_sys_metadata_field(0x9900000300000500 + i * 2 + j, &val)))
> -				sysinfo_td_conf->cpuid_config_values[i][j] = val;
> -
> -	return ret;
> +	pr_info("header 0x%016llx id 0x%016llx elements_in_field %d field %d\n", sequence->sequence_header.raw, base_id,
> +		sequence->sequence_header.last_element_in_field + 1,
> +		sequence->sequence_header.last_field_in_sequence + 1);
> +
> +	/* Iterate over all elements in the sequence */
> +	for (i = 0; i < num_elements; i++) {
> +		field_id = base_id + i;
> +		data = sequence->element + i;
> +
> +		switch (field_id) {
> +		#define READ_TDX_MD(name, field)			\
> +			case (TDX_MD_ID_##name & TDX_MD_ID_MASK):	\
> +				field = *data;				\
> +				break;
> +
> +		READ_TDX_MD(MINOR_VERSION, sysinfo->version.minor_version);
> +		READ_TDX_MD(MAJOR_VERSION, sysinfo->version.major_version);
> +		READ_TDX_MD(UPDATE_VERSION, sysinfo->version.update_version);
> +
> +		READ_TDX_MD(MODULE_HV, sysinfo->handoff.module_hv);
> +
> +		READ_TDX_MD(TDX_FEATURES0, sysinfo->features.tdx_features0);
> +
> +		READ_TDX_MD(MAX_TDMRS, sysinfo->tdmr.max_tdmrs);
> +		READ_TDX_MD(MAX_RESERVED_PER_TDMR, sysinfo->tdmr.max_reserved_per_tdmr);
> +		READ_TDX_MD(PAMT_4K_ENTRY_SIZE, sysinfo->tdmr.pamt_4k_entry_size);
> +		READ_TDX_MD(PAMT_2M_ENTRY_SIZE, sysinfo->tdmr.pamt_2m_entry_size);
> +		READ_TDX_MD(PAMT_1G_ENTRY_SIZE, sysinfo->tdmr.pamt_1g_entry_size);
> +
> +		READ_TDX_MD(TDR_BASE_SIZE, sysinfo->td_ctrl.tdr_base_size);
> +		READ_TDX_MD(TDCS_BASE_SIZE, sysinfo->td_ctrl.tdcs_base_size);
> +		READ_TDX_MD(TDVPS_BASE_SIZE, sysinfo->td_ctrl.tdvps_base_size);
> +
> +		READ_TDX_MD(ATTRIBUTES_FIXED0, sysinfo->td_conf.attributes_fixed0);
> +		READ_TDX_MD(ATTRIBUTES_FIXED1, sysinfo->td_conf.attributes_fixed1);
> +		READ_TDX_MD(XFAM_FIXED0, sysinfo->td_conf.xfam_fixed0);
> +		READ_TDX_MD(XFAM_FIXED1, sysinfo->td_conf.xfam_fixed1);
> +		READ_TDX_MD(NUM_CPUID_CONFIG, sysinfo->td_conf.num_cpuid_config);
> +		READ_TDX_MD(MAX_VCPUS_PER_TD, sysinfo->td_conf.max_vcpus_per_td);
> +		#undef READ_TDX_MD
> +
> +		case TDX_MD_ID_CPUID_CONFIG_LEAVES & TDX_MD_ID_MASK:
> +			for (j = 0; j < sysinfo->td_conf.num_cpuid_config; j++)
> +				sysinfo->td_conf.cpuid_config_leaves[j] = data[j];
> +			/* return as all elements in this sequence are handled */
> +			return;
> +		case TDX_MD_ID_CPUID_CONFIG_VALUES & TDX_MD_ID_MASK:
> +			for (j = 0; j < sysinfo->td_conf.num_cpuid_config; j++) {
> +				sysinfo->td_conf.cpuid_config_values[j][0] = data[2*j];
> +				sysinfo->td_conf.cpuid_config_values[j][1] = data[2*j+1];
> +			}
> +			/* return as all elements in this sequence are handled */
> +			return;
> +		default:
> +			break;
> +		}
> +	}
>  }
>  
> -static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
> +static void parse_md_list(struct md_list_header *list_header, struct tdx_sys_info *sysinfo)
>  {
> -	int ret = 0;
> -	u64 val;
> -
> -	if (tdx_supports_runtime_update(&tdx_sysinfo) &&
> -	    !(ret = read_sys_metadata_field(0x8900000100000000, &val)))
> -		sysinfo_handoff->module_hv = val;
> -
> -	return ret;
> +	struct md_sequence *sequence;
> +	u32 num_elements;
> +	int i = 0;
> +
> +	pr_info("header: buff_size %u, num_sequences %u\n",
> +		list_header->list_buff_size,
> +		list_header->num_sequences);
> +
> +	sequence = (struct md_sequence *)(list_header + 1);
> +
> +	while (i < list_header->num_sequences) {
> +		num_elements = (sequence->sequence_header.last_element_in_field + 1) *
> +			       (sequence->sequence_header.last_field_in_sequence + 1);
> +		parse_md_sequence(sequence, sysinfo);
> +		sequence = (struct md_sequence *)(&sequence->element[num_elements]);
> +		i++;
> +	}
>  }
>  
>  static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  {
> +	unsigned long buffer;
> +	u64 field_id = -1;
> 	int ret = 0;
>  
> -	ret = ret ?: get_tdx_sys_info_version(&sysinfo->version);
> -	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
> -	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
> -	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
> -	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
> -	ret = ret ?: get_tdx_sys_info_handoff(&sysinfo->handoff);
> +	buffer = __get_free_page(GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	do {
> +		ret = read_sys_metadata_field(&field_id, (void *)buffer);
> +		if (ret)
> +			break;
> +		parse_md_list((void *)buffer, sysinfo);
> +	} while (field_id != -1);
> +
> +	free_page(buffer);
> +	if (ret)
> +		pr_info("TDX sysinfo version read all failed: %d\n", ret);
>  
> 	return ret;
>  }
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

